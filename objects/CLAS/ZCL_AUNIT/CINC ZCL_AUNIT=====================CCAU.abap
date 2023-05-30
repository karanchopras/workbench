*"* use this source file for your ABAP unit test classes
CLASS ltc_demo_calc_util DEFINITION FOR TESTING
                         RISK LEVEL HARMLESS
                         DURATION SHORT.

  PUBLIC SECTION.
    METHODS:
      t_add      FOR TESTING,
      t_multiply FOR TESTING,
      t_subtract FOR TESTING.
  PRIVATE SECTION.
    DATA:
      lo_cut TYPE REF TO zcl_aunit.
    METHODS:
      setup.
ENDCLASS.

CLASS ltc_demo_calc_util IMPLEMENTATION.

  METHOD setup.
    "given - Instantiate the Production Class
    lo_cut = NEW zcl_aunit( ).
  ENDMETHOD.

  METHOD t_add.

    "when
    DATA(lv_result) = lo_cut->add( 3 ).
    "then
    cl_abap_unit_assert=>assert_equals(
        msg = 'Something Wrong with Addition!'
        exp = 6
        act = lv_result ).
  ENDMETHOD.

  METHOD t_multiply.

    "when
    DATA(lv_result) = lo_cut->multiply( 3 ).
    "then
    cl_abap_unit_assert=>assert_equals(
        msg = 'Something Wrong with Multiplication!'
        exp = 13
        act = lv_result ).
  ENDMETHOD.
  METHOD t_subtract.

    "when
    DATA(lv_result) = lo_cut->subtract( EXPORTING iv_num1 = 7
                                                 iv_num2 = 4 ).
    "then
    cl_abap_unit_assert=>assert_equals(
        msg = 'Check the Subtraction Logic !'
        exp = 4
        act = lv_result ).

    cl_abap_unit_assert=>assert_differs(
            msg = 'Check the Subtraction Logic!'
            exp = 7
            act = lv_result ).

  ENDMETHOD.
ENDCLASS.