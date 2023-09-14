  METHOD commit_goods_mvmt.

    DATA(lv_return) = VALUE bapiret2( ).

    IF lines( it_return ) > 0.

      CALL FUNCTION 'BAPI_TRANSACTION_ROLLBACK'
        IMPORTING
          return = lv_return.
      ""Handle displaying Error message of unsuccessful commmit.
    ELSE.
      CALL FUNCTION 'BAPI_TRANSACTION_COMMIT'
        EXPORTING
          wait   = abap_true
        IMPORTING
          return = lv_return.

*    Others.
*      ""Handle displaying Error message of unsuccessful commmit.
    ENDIF.

  ENDMETHOD.