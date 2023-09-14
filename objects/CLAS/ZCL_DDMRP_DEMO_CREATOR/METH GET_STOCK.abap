  METHOD get_stock.

    "Calculate Days and Total Quantity to be "issued" against stock to avoid negative posting

    DATA : ls_return     TYPE bapiret2,
           lt_mrp_items  TYPE TABLE OF bapi_mrp_items,
           ls_mrp_list   TYPE bapi_mrp_list,
           lv_matnr_conv TYPE matnr18.


    CALL FUNCTION 'CONVERSION_EXIT_ALPHA_OUTPUT'
      EXPORTING
        input  = iv_material
      IMPORTING
        output = lv_matnr_conv.

        CALL FUNCTION 'CONVERSION_EXIT_MATN1_INPUT'
          EXPORTING
            input        = lv_matnr_conv
          IMPORTING
            output       = lv_matnr_conv
          EXCEPTIONS
            length_error = 1
            OTHERS       = 2.
        IF sy-subrc <> 0.
* Implement suitable error handling here
        ENDIF.

    CALL FUNCTION 'BAPI_MATERIAL_STOCK_REQ_LIST'
      EXPORTING
        material         = lv_matnr_conv
        plant            = iv_plant
        get_item_details = 'X'
        get_ind_lines    = 'X'
      IMPORTING
        mrp_list         = ls_mrp_list
        return           = ls_return
      TABLES
        mrp_items        = lt_mrp_items.


    IF ls_return-type = 'E' OR ls_return-type = 'A'.
      SHIFT lv_matnr_conv LEFT DELETING LEADING '0'.
      MESSAGE e001(zddmrp_dmo) WITH ls_return-message DISPLAY LIKE 'S'.


    ELSEIF ls_return-type = 'S' or ls_return-type = 'W'.

*      MESSAGE s001(zddmrp_dmo) WITH ls_return-message.
      Message s013(zddmrp_dmo) WITH iv_material iv_plant ls_mrp_list-plnt_stock DISPLAY LIKE 'S'.
      ev_total_stock = ls_mrp_list-plnt_stock.
      ev_uom = ls_mrp_list-base_uom.

    ENDIF.

*@ log: material, plant, stock level



  ENDMETHOD.