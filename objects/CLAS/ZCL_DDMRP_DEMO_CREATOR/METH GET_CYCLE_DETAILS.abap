  METHOD get_cycle_details.

    CLEAR : ms_cycle_head, mt_cycle_item.

    SELECT SINGLE * FROM zcycle_head
      INTO @ms_cycle_head
      WHERE cyc_name = @iv_cycle_selection.

    IF ms_cycle_head IS NOT INITIAL.
      SELECT * FROM zcycle_item
       INTO TABLE @mt_cycle_item
       WHERE cyc_header_id = @ms_cycle_head-cyc_header_id.

      IF mt_cycle_item IS INITIAL.
        MESSAGE e003(zddmrp_dmo) WITH iv_cycle_selection DISPLAY LIKE 'S'.
      ENDIF.

    ELSE.
      MESSAGE e002(zddmrp_dmo) WITH iv_cycle_selection DISPLAY LIKE 'S'.
    ENDIF.



  ENDMETHOD.