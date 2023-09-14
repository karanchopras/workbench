private section.

  types:
    BEGIN OF ts_mard_key,
        matnr TYPE matnr,
        werks TYPE werks_d,
        lgort TYPE lgort_d,
      END OF ts_mard_key .
  types:
    tt_mard_key TYPE STANDARD TABLE OF ts_mard_key .

  data MT_MARD_KEY type TT_MARD_KEY .

  methods ADD_VARIANCE
    importing
      !IV_VARIANCE type INT2
    changing
      !CV_MAT_QUANTITY type TS_MAT_QUAN .
  methods GET_VARIANCE
    changing
      !CV_VARIANCE type INT2 .