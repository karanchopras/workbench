*&---------------------------------------------------------------------*
*& Report ZDDMRP_POST_GOODS_MOV
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zddmrp_post_goods_mov.



PARAMETERS: p_sel  TYPE char20 OBLIGATORY,
            p_cyc  TYPE char20 OBLIGATORY,
            p_stdt TYPE dats OBLIGATORY.

START-OF-SELECTION.

  DATA go_ddmrp TYPE REF TO zcl_ddmrp_demo_creator.

  CREATE OBJECT go_ddmrp
    EXPORTING
      im_selection       = p_sel
      im_cycle_selection = p_cyc.




IF sy-subrc = 0.

  CALL METHOD go_ddmrp->main
    EXPORTING
       iv_start_date      = p_stdt
      .

ENDIF.