resource "oci_nosql_table" "nosql_table" {
  compartment_id = var.compartment_id

  for_each = var.table_definitions
  ddl_statement  = each.value.statement
  name           = each.value.table_name

  table_limits {
    max_read_units      = var.max_read_units
    max_write_units     = var.max_write_units
    max_storage_in_gbs  = var.max_storage_in_gbs
    capacity_mode = var.capacity_mode
  }
  is_auto_reclaimable = var.is_auto_reclaimable
 
 #Optional
   #defined_tags     = var.defined_tags
    #freeform_tags    = var.freeform_tags

}
