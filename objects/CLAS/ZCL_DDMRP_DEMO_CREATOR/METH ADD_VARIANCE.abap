  method ADD_VARIANCE.

        cv_mat_quantity = cv_mat_quantity + ( cv_mat_quantity * ( iv_variance / 100 ) ) .
        cv_mat_quantity = round(  val = cv_mat_quantity dec = 0 ).
        SHIFT cv_mat_quantity LEFT DELETING LEADING space.

  endmethod.