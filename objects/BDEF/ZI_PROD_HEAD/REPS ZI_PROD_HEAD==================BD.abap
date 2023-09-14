managed implementation in class zbp_i_prod_head unique;
strict ( 2 );

define behavior for ZI_PROD_HEAD alias ProductHeader
persistent table zprod_sel_head
lock master
authorization master ( instance )
etag master LocalLastChangedAt
{
  create;
  update;
  delete;

  field ( numbering : managed, readonly ) HeaderId;
  field ( readonly ) LastChangedAt, LocalLastChangedAt, LastChangedBy, CreatedBy, CreatedAt;

  association _ProductItem { create; }

  mapping for ZPROD_SEL_HEAD
  {
    HeaderId = header_id;
    SelectionName = selection_name;
    Description = description;
    CostCenter = cost_center;
    StorageLocation = storage_loc;
//    Active = active;
    CreatedBy = created_by;
    CreatedAt = created_at;
    LastChangedBy = last_changed_by;
    LastChangedAt = last_changed_at;
    LocalLastChangedAt = local_last_changed_at;
  }

}



define behavior for ZI_PROD_ITEM //alias <alias_name>
persistent table zprod_sel_item
lock dependent by _ProductHeader
authorization dependent by _ProductHeader
//etag master <field_name>
etag master LocalLastChangedAt
{
  update;
  delete;

  field ( readonly ) HeaderId,LastChangedAt, LocalLastChangedAt, LastChangedBy, CreatedBy, CreatedAt;
  field ( numbering : managed, readonly ) ItemID;

  association _ProductHeader;

  mapping for ZPROD_SEL_ITEM
  {
    ItemId = item_id;
    HeaderId = header_id;
    FieldName = field_name;
//    Material = material;
    Description = description;
    Highvalue = highvalue;
    LowValue = low_value;
    SignCode = sign_code;
    OptionCode = option_code;
    CreatedBy = created_by;
    CreatedAt = created_at;
    LastChangedBy = last_changed_by;
    LastChangedAt = last_changed_at;
    LocalLastChangedAt = local_last_changed_at;
  }

}