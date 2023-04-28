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
* Dynamic Expression
DATA: v_original   TYPE string,
      v_expression TYPE string,
      v_output     TYPE string.


START-OF-SELECTION .

*New Comment 25-11
*23_03_2023
*New Comment - 23-11
  v_original = 'BGsy2y_CoojoP8G8BkD_EoBvHUj6BoB_EwCjDgFvCsEToGA7B0F7BwHnBkIT8GAkIUsJ8B4I8BoGwCoGkDoG4D0F4DsEsEsE0FgF8G0FsEsE4D0F4D8GkD0FkD8GgKoV4I0UsEsJ4DwH4D8G4DoG'.

  js_processor = cl_java_script=>create( ).
*  SELECT * FROM mara INTO TABLE @DATA(lt_mara).

  DATA: v_org_str TYPE string.
  DATA: v_exp_str TYPE string.
  v_org_str = 'var V_INPU T = ' && '"' && v_original && '"' && ';'.