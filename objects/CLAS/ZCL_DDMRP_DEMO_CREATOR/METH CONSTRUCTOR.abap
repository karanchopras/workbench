  METHOD constructor.

    Data : lt_sel_item  TYPE ts_sel_item,
           lt_selection TYPE zprod_sel_head,
           lt_cycle_item TYPE ts_cyc_item,
           ls_cycle_selection TYPE zcycle_head.

    "read all details
    CALL METHOD me->get_sel_details
      EXPORTING
        iv_selection = im_selection.

    CALL METHOD me->get_cycle_details
      EXPORTING
        iv_cycle_selection = im_cycle_selection.

*    CALL METHOD me->calc_cycle_day
*      EXPORTING
*        iv_start_date = im_start_date.

  ENDMETHOD.