  METHOD create_selection.


    DATA : lt_selopt    TYPE TABLE OF ddshselopt,
           lv_where     TYPE string,
           lv_highvalue TYPE c LENGTH 40,
           lv_lowvalue  TYPE c LENGTH 40.
    FIELD-SYMBOLS <fs_selopt> TYPE ddshselopt.

    LOOP AT mt_prod_item ASSIGNING FIELD-SYMBOL(<fs_prod_item>).

      IF <fs_prod_item>-field_name = 'MATNR'.

        CALL FUNCTION 'CONVERSION_EXIT_MATN1_INPUT'
          EXPORTING
            input        = <fs_prod_item>-low_value
          IMPORTING
            output       = <fs_prod_item>-low_value
          EXCEPTIONS
            length_error = 1
            OTHERS       = 2.
        IF sy-subrc <> 0.
* Implement suitable error handling here
        ENDIF.
      ENDIF.

*      IF <fs_prod_item>-field_name = 'LGORT'. "@ To be removed on update !
*      IF ms_prod_head-storage_loc IS INITIAL.
*       ms_prod_head-storage_loc = <fs_prod_item>-low_value.
*      ENDIF.
*      ENDIF.



      APPEND VALUE #(
      shlpfield = <fs_prod_item>-field_name
      sign     = <fs_prod_item>-sign_code
      option   = <fs_prod_item>-option_code
      high     = <fs_prod_item>-highvalue
      low      = <fs_prod_item>-low_value

      ) TO lt_selopt.

    ENDLOOP.

    CALL FUNCTION 'F4_CONV_SELOPT_TO_WHERECLAUSE'
      IMPORTING
        where_clause = lv_where
      TABLES
        selopt_tab   = lt_selopt.

    TRY.
        SELECT matnr, werks FROM marc INTO TABLE @mt_selection WHERE (lv_where).
        IF sy-subrc <> 0.
          MESSAGE e012(zddmrp_dmo).
        ENDIF.
*@ log: number of materials
      CATCH cx_sy_dynamic_osql_syntax.
        MESSAGE e014(zddmrp_dmo) DISPLAY LIKE 'S'.
    ENDTRY.

  ENDMETHOD.