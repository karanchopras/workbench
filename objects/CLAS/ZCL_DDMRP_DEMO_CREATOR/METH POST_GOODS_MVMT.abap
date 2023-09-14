  METHOD post_goods_mvmt.

*    Data it_return TYPE STANDARD TABLE OF bapiret2.
    DATA lv_mvt_code TYPE bapi2017_gm_code.
    DATA(lv_headret) = VALUE bapi2017_gm_head_ret( ).
    DATA lv_uom TYPE meins.

    IF sy-subrc = 0.
*    Header
      DATA(lv_header) = VALUE bapi2017_gm_head_01( pstng_date    = sy-datum
                                                   doc_date      = sy-datum
                                                   pr_uname      = sy-uname
*                                               gr_gi_slip_no = ''
*                                               header_txt    = 'Text1'
*                                               ref_doc_no    = ''
                                                 ).


      CALL FUNCTION 'CONVERSION_EXIT_CUNIT_INPUT'
        EXPORTING
          input          = is_ms_cycle_item-uom
          language       = sy-langu
        IMPORTING
          output         = lv_uom
        EXCEPTIONS
          unit_not_found = 1
          OTHERS         = 2.

      IF sy-subrc <> 0.
        MESSAGE e009(zddrmp_dmo) WITH iv_material.
      ENDIF.


      DATA(it_items_to_move) = VALUE bapi2017_gm_item_create_t( (  material       = iv_material
                                                                   plant          = iv_plant
                                                                   stge_loc       = iv_storage_loc
                                                                   move_type      = is_ms_cycle_item-movement_type
                                                                   "mvt_ind       = ''
                                                                   entry_qnt      = is_ms_cycle_item-material_quantity
                                                                   entry_uom      = lv_uom
                                                                   "entry_uom_iso = im_ms_cycle_item-uom
                                                                   "gl_account    = ''
                                                                   "gr_rcpt       = ''
                                                                   costcenter     = iv_CostCenter
                                                                   "orderid       = ''
                                                                   "wbs_elem      = ''
                                                                  ) ).

      IF is_ms_cycle_item-movement_type = '201'.  " Movement code for Goods issue
        lv_mvt_code = VALUE #( gm_code = '03' ).
      ELSEIF is_ms_cycle_item-movement_type = '561'. " Movement code for Goods receipt
        lv_mvt_code = VALUE #( gm_code = '05' ). "05 for other gooods movement
      ENDIF.


      CALL FUNCTION 'BAPI_GOODSMVT_CREATE'
        EXPORTING
          goodsmvt_header  = lv_header
          goodsmvt_code    = lv_mvt_code
        IMPORTING
          goodsmvt_headret = lv_headret
        TABLES
          goodsmvt_item    = it_items_to_move
          return           = et_return.


      IF et_return IS NOT INITIAL." Read IT_RETURN For any erros and post it in display message class.
        MESSAGE s011(zddmrp_dmo) WITH iv_material.
        LOOP AT et_return ASSIGNING FIELD-SYMBOL(<fs_return>).
          MESSAGE e007(zddmrp_dmo) WITH <fs_return>-message.
        ENDLOOP.

      ELSEIF lv_headret IS NOT INITIAL.
        MESSAGE s011(zddmrp_dmo) WITH iv_material is_ms_cycle_item-material_quantity lv_uom is_ms_cycle_item-movement_type .
        MESSAGE s008(zddmrp_dmo) WITH lv_headret-mat_doc lv_headret-doc_year.

      ENDIF.

    ENDIF.





  ENDMETHOD.