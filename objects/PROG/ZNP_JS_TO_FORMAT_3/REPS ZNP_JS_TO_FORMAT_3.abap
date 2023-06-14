*&---------------------------------------------------------------------*
*& Report ZNP_JS_TO_FORMAT_3
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT znp_js_to_format_3.


DATA: js_processor TYPE REF TO cl_java_script,
      js_source    TYPE string,
      return_value TYPE string.
* New comment v12
* Dynamic Expressionv
DATA: v_original   TYPE string,
      v_expression TYPE string,
      v_output     TYPE string.


START-OF-SELECTION .

*New comiit for jenkins v5

*New Comment - 23-13
  v_original = 'Change 5'.

  js_processor = cl_java_script=>create( ).
*  SELECT * FROM mara INTO TABLE @DATA(lt_mara).

  DATA: v_org_str TYPE string.
  DATA: v_exp_str TYPE string.
  v_org_str = 'var V_INPU T = ' && '"' && v_original && '"' && ';'.