  METHOD calc_cycle_day.

    DATA(lv_diff) = sy-datum - iv_start_date.
    DATA(lv_cycle_len) = lines( mt_cycle_item ).


      ev_cycle_day = ( ( lv_diff + 1 ) MOD lv_cycle_len ).    "Set the index/day

   "" IF ( lv_diff + 1 ) - lv_cycle_len = 0. "" if setting index is 0
    if ev_cycle_day = 0.  " if setting index is 0 set to last index
      ev_cycle_day = lv_cycle_len.
    ENDIF.


  ENDMETHOD.