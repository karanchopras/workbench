*&---------------------------------------------------------------------*
*& Report ZNP_JS_TO_FORMAT_3
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT znp_js_to_format_4.


DATA: js_processor TYPE REF TO cl_java_script,
      js_source    TYPE string,
      return_value TYPE string.
* New comment v12
* Dynamic Expression
DATA: v_original   TYPE string,
      v_expression TYPE string,
      v_output     TYPE string.


START-OF-SELECTION.

*New Comment 04/06


  v_original = 'BGsy2y_ CoojoP8G8BkD_EoBvHU_j6BoB_EwCjDgFvCsEToGA7B0F7BwHnBkIT8GAkIUsJ8B.V1'.

  js_processor = cl_java_script=>create( ).
*  SELECT * FROM mara INTO TABLE @DATA(lt_mara) .
