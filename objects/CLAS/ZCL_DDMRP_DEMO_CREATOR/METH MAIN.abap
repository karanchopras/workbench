  METHOD main.

    DATA : ls_return    TYPE bapiret2,
           lt_return    TYPE bapiret2_T,
           lt_mrp_items TYPE TABLE OF bapi_mrp_items,
           lv_stock     TYPE mng01,
           lv_uom       TYPE meins,
           lv_cycle_day TYPE i.

    CALL METHOD me->calc_cycle_day
      EXPORTING
        iv_start_date = iv_start_date
      IMPORTING
        ev_cycle_day  = lv_cycle_day.

    IF lv_cycle_day <> 0.

      READ TABLE mt_cycle_item ASSIGNING FIELD-SYMBOL(<fs_cycle_item>) WITH KEY cyc_day = lv_cycle_day.

      CALL METHOD me->create_selection.

      LOOP AT mt_selection ASSIGNING FIELD-SYMBOL(<fs_selection>). ""Start Posting for Materials ..

        CALL METHOD me->get_stock
          EXPORTING
            iv_material    = <fs_selection>-material
            iv_plant       = <fs_selection>-plant
          IMPORTING
            ev_total_stock = lv_stock
            ev_uom         = lv_uom.        ""Enter UOM for posting


        CALL METHOD me->get_variance
          CHANGING
            cv_variance = <fs_cycle_item>-variance.

        CALL METHOD me->add_variance
          EXPORTING
            iv_variance = <fs_cycle_item>-variance
          CHANGING
            cv_mat_quantity = <fs_cycle_item>-material_quantity.

*        TRY.
*            <fs_cycle_item>-variance = cl_abap_random_int=>create( seed = cl_abap_random=>seed( )
*                                                              min  = CONV i( -1 * <fs_cycle_item>-variance )
*                                                              max  = CONV i( <fs_cycle_item>-variance ) )->get_next( ).
*
*          CATCH cx_abap_random.
*        ENDTRY.

*        <fs_cycle_item>-material_quantity = <fs_cycle_item>-material_quantity + ( <fs_cycle_item>-material_quantity * ( <fs_cycle_item>-variance / 100 ) ) .
*        <fs_cycle_item>-material_quantity = round(  val = <fs_cycle_item>-material_quantity dec = 0 ).
*        SHIFT <fs_cycle_item>-material_quantity LEFT DELETING LEADING space.

        IF NOT lv_stock IS INITIAL AND lv_stock - <fs_cycle_item>-material_quantity > 0  OR <fs_cycle_item>-movement_type = '561'. "Post only if total stock is positive

          CALL METHOD me->post_goods_mvmt
            EXPORTING
              iv_costcenter    = ms_prod_head-cost_center
              is_ms_cycle_item = <fs_cycle_item>
              iv_plant         = <fs_selection>-plant
              iv_material      = <fs_selection>-material
              iv_uom           = lv_uom
              iv_storage_loc   = ms_prod_head-storage_loc
            IMPORTING
              et_return        = lt_return.

          IF lt_return IS INITIAL. ""test and loop on return conditions and describe Errors. e.g cost center issue.
            CALL METHOD me->commit_goods_mvmt
              EXPORTING
                it_return = lt_return.
          ENDIF.

        ELSEIF lv_stock - <fs_cycle_item>-material_quantity < 0.  """Skip if total stock is negative
          SHIFT <fs_selection>-material LEFT DELETING LEADING '0' .
          MESSAGE e006(zddmrp_dmo) WITH lv_cycle_day <fs_selection>-material <fs_cycle_item>-material_quantity DISPLAY LIKE 'S'.
        ENDIF.

      ENDLOOP.

    ELSEIF lv_cycle_day = 0.              ""Exception for cycle lengths

      MESSAGE e010(zddmrp_dmo) DISPLAY LIKE 'S'.

    ENDIF.

  ENDMETHOD.