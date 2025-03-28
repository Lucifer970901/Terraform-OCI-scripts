output "table_names" {
  description = "The name of the created NoSQL table"
  value = { for k, v in oci_nosql_table.nosql_table: k => v.name }

}

output "table_ids" {
  description = "The OCID of the created NoSQL table"
  value = { for k, v in oci_nosql_table.nosql_table: k => v.id }
}
