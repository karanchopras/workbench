  METHOD get_sel_details.

    CLEAR : ms_prod_head, mt_prod_item.

    SELECT SINGLE * FROM zprod_sel_head
      INTO @ms_prod_head
      WHERE selection_name = @iv_selection.

    IF ms_prod_head IS NOT INITIAL.
      SELECT * FROM zprod_sel_item
        INTO TABLE @mt_prod_item
        WHERE header_id = @ms_prod_head-header_id.

      IF mt_prod_item IS INITIAL.
        MESSAGE e005(zddmrp_dmo) WITH iv_selection DISPLAY LIKE 'S'.
      ENDIF.

    ELSE.
      MESSAGE e004(zddmrp_dmo) WITH iv_selection DISPLAY LIKE 'S'.
    ENDIF.

*    SELECT * FROM mard INTO CORRESPONDING FIELDS OF TABLE mt_mard_key
*      WHERE matnr = '179' AND werks = 'DEB2' AND lgort = '101A'.


  ENDMETHOD.