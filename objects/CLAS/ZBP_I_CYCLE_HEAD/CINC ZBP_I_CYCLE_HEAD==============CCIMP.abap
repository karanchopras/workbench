CLASS lhc_ZI_CYCLE_HEAD DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zi_cycle_head RESULT result.

ENDCLASS.

CLASS lhc_ZI_CYCLE_HEAD IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

ENDCLASS.