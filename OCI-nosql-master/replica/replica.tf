resource "oci_nosql_table_replica" "this" {
    for_each = var.table_ids
    
    region = var.replica_region
    table_name_or_id = each.value

    compartment_id = var.compartment_id
    max_read_units = var.replica_max_read_units
    max_write_units = var.replica_max_write_units
}
