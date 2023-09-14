  METHOD get_variance.

    TRY.
        cv_variance = cl_abap_random_int=>create( seed = cl_abap_random=>seed( )
                                                          min  = CONV i( -1 * cv_variance )
                                                          max  = CONV i( cv_variance ) )->get_next( ).

      CATCH cx_abap_random.
    ENDTRY.

  ENDMETHOD.