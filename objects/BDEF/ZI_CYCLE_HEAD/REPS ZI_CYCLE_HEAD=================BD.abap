managed implementation in class zbp_i_cycle_head unique;
//strict ( 2 );

define behavior for ZI_CYCLE_HEAD //alias <alias_name>
persistent table zcycle_head
lock master
authorization master ( instance )
//etag master LocalLastChangedAt
{
  create;
  update;
  delete;

  field ( numbering : managed, readonly ) CycHeaderId;
  field ( readonly ) LastChangedAt, LocalLastChangedAt, LastChangedBy, CreatedBy, CreatedAt;


  association _CycleItem { create; }


  mapping for zcycle_head
  {

    CycHeaderId = cyc_header_id;
    CycName = cyc_name;
    CycDescription = cyc_description;
    Active = active;
    Variance = variance;
    CreatedBy = created_by;
    CreatedAt = created_at;
    LastChangedBy = last_changed_by;
    LastChangedAt = last_changed_at;
    LocalLastChangedAt = local_last_changed_at;

  }


}

define behavior for ZI_CYCLE_ITEM //alias <alias_name>
persistent table zcycle_item
lock dependent by _CycleHeader
authorization dependent by _CycleHeader
//etag master LocalLastChangedAt
//etag master <field_name>
{
  update;
  delete;

  field ( numbering : managed, readonly ) ItemId;
  field ( readonly ) CycHeaderId, LastChangedAt, LocalLastChangedAt, LastChangedBy, CreatedBy, CreatedAt;

  association _CycleHeader;


  mapping for zcycle_item
  {

    ItemId = item_id;
    CycHeaderId = cyc_header_id;
    CycDay = cyc_day;
    MovementType = movement_type;
    MaterialQuantity = material_quantity;
    UnitofMeasure = uom;
    Variance = variance;
    CreatedBy = created_by;
    CreatedAt = created_at;
    LastChangedBy = last_changed_by;
    LastChangedAt = last_changed_at;
    LocalLastChangedAt = local_last_changed_at;

  }

}