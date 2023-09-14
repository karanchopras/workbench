class ZCL_DDMRP_DEMO_CREATOR definition
  public
  create public .

public section.

  types:
    ts_sel_item TYPE TABLE OF zprod_sel_item .
  types:
    ts_cyc_item TYPE TABLE OF zcycle_item .
  types:
    TS_MAT_QUAN TYPE C LENGTH 13 .
  types:
    BEGIN OF ts_selection,
        material TYPE matnr,
        plant    TYPE marc-werks,
        location TYPE mard-lgort,
      END OF ts_selection .
  types:
    tt_selection TYPE STANDARD TABLE OF ts_selection .

  data MS_CYCLE_HEAD type ZCYCLE_HEAD .
  data:
    mt_cycle_item TYPE TABLE OF zcycle_item .
  data MS_PROD_HEAD type ZPROD_SEL_HEAD .
  data:
    mt_prod_item TYPE TABLE OF zprod_sel_item .
  data:
    mt_stock_list TYPE TABLE OF bapi_mrp_items .
  data MT_SELECTION type TT_SELECTION .

  methods MAIN
    importing
      !IV_START_DATE type SY-DATUM optional
      !IV_COSTCENTER type KOSTL optional .
  methods CONSTRUCTOR
    importing
      !IM_SELECTION type CHAR20 optional
      !IM_CYCLE_SELECTION type CHAR20 optional
      !IM_START_DATE type SY-DATUM optional
      !EX_CYCLE_DAY type I optional .
  methods GET_CYCLE_DETAILS
    importing
      !IV_CYCLE_SELECTION type CHAR20 optional
    exporting
      !ES_CYCLE_SELECTION type ZCYCLE_HEAD
      !ET_CYCLE_ITEM type TS_CYC_ITEM .
  methods GET_SEL_DETAILS
    importing
      !IV_SELECTION type CHAR20 optional
    exporting
      !ET_SEL_ITEM type TS_SEL_ITEM
      !ES_SELECTION type ZPROD_SEL_HEAD .
  methods CREATE_SELECTION .
  methods GET_STOCK
    importing
      !IV_MATERIAL type MATNR
      !IV_PLANT type WERKS_D
    exporting
      !EV_TOTAL_STOCK type MNG01
      !EV_UOM type MEINS .
  methods CALC_CYCLE_DAY
    importing
      !IV_START_DATE type SY-DATUM
    exporting
      !EV_CYCLE_DAY type I .
  methods POST_GOODS_MVMT
    importing
      !IV_COSTCENTER type KOSTL
      !IS_MS_CYCLE_ITEM type ZCYCLE_ITEM
      !IV_PLANT type WERKS_D
      !IV_MATERIAL type MATNR
      !IV_UOM type MEINS
      !IV_STORAGE_LOC type MARD-LGORT
    exporting
      !ET_RETURN type BAPIRET2_T .
  methods COMMIT_GOODS_MVMT
    importing
      !IT_RETURN type BAPIRET2_T .