

locals {
  GA_table_creation_ddl_statements = {

    ##################################################################################################################
    # Fixed Schema - This table has explicitly defined columns
    # Partially flexible - only the 'info' column is JSON (semi-strucutred data), the rest of the fileds have fixed types
    #####################################################################################################################
    hybrid_ddl_statement = {
      statement  = <<-EOT
      CREATE TABLE IF NOT EXISTS ${var.hybrid_table_name} (
        id INTEGER,
        name STRING,
        info JSON,
        PRIMARY KEY(id)
      ) WITH SCHEMA FROZEN
      EOT
      table_name = var.hybrid_table_name
    }
  }

}

module "nosql_demo_replica" {

  depends_on        = [module.nosql_demo]
  source            = "./nosql"
  compartment_id    = var.compartment_id
  table_definitions = local.GA_table_creation_ddl_statements

  max_read_units      = var.table_limits_max_read_units
  max_write_units     = var.table_limits_max_write_units
  max_storage_in_gbs  = var.table_limits_max_storage_in_gbs
  capacity_mode       = var.capacity_mode
  is_auto_reclaimable = var.is_auto_reclaimable


  providers = {
    oci             = oci
    oci.home_region = oci.home_region
  }
}


module "nosql_replica" {
  depends_on = [module.nosql_demo_replica]
  source     = "./replica"

  compartment_id          = var.compartment_id
  replica_region          = var.replica_region
  replica_max_read_units  = var.replica_max_read_units
  replica_max_write_units = var.replica_max_write_units
  table_ids               = module.nosql_demo_replica.table_ids
  providers = {
    oci             = oci
    oci.home_region = oci.home_region
  }

}
  