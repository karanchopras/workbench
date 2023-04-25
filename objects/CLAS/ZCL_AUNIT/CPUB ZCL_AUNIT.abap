CLASS zcl_aunit DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS add
      IMPORTING
        !iv_num1      TYPE i
      RETURNING
        VALUE(rv_sum) TYPE i .
    METHODS multiply
      IMPORTING
        !iv_num1         TYPE i
      RETURNING
        VALUE(rv_result) TYPE i .
    METHODS subtract
      IMPORTING
        !iv_num1         TYPE i
        !iv_num2         TYPE i
      RETURNING
        VALUE(rv_result) TYPE i .