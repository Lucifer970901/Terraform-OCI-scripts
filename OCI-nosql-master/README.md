# Oracle Cloud Infrastructure (OCI) NoSQL Terraform Module

This repository contains Terraform modules which provisions an OCI NoSQL table with configurable parameters such as read/write units, storage capacity, and capacity mode. 

## Module Overview

1. **NoSQL Tables:**
   - The `module-nosql.tf` creates two tables: one with a hybrid schema and the other schemaless.
2. **Global Active Tables:**
   - The `module-global-active-tables.tf` creates active/active replicas across multiple cloud regions.
   - To create a Global Active Table:
     - The table DDL definition must include the `WITH SCHEMA FROZEN` clause.
     - The table should contain at least one JSON column.
     - The table should not contain an `IDENTITY` column.
3. **Schema Evolution with Overrides:**
   - The `override.tf` file defines changes to the existing NoSQL Database schema.
   - The database is optimized for append-only schema changes:
     - Add/modify columns only at the end.
     - Instead of renaming columns in NoSQL, create a new column and handle renaming at the application level.
     - For major schema changes, recreate the table:
       - Create a new table with the updated schema.
       - Migrate existing data.
       - Drop the old table.

## Important Notes

- The definition of the singleton table (e.g., `CREATE TABLE IF NOT EXISTS nosql_demo…`) must always be included in the Terraform script, even if the table already exists.
  - If the table exists, Terraform compares its definition with the script.
  - If there are no changes, the `CREATE TABLE` definition is ignored.
  - If there are changes, Terraform overwrites the table definition (equivalent to an `ALTER TABLE` statement).
  - If the table is missing from the script, Terraform may drop it from the region.

- When Terraform processes `override.tf`, it compares the new DDL statement with the current schema and generates an `ALTER TABLE` statement to apply modifications.

- To prevent unintentional deletion or modification due to schema evolution, use:

  ```hcl
  lifecycle {
    ignore_changes = [ddl_statement]
  }
  ```

## Pre-requisites

Ensure you have the following before using this module:

- [OpenTofu](https://opentofu.org/docs/intro/install/) or [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli) installed
- An Oracle Cloud Infrastruture(OCI) Account
- [Configure OCI CLI](https://docs.oracle.com/en-us/iaas/Content/dev/terraform/tutorials/tf-provider.htm#prepare) with appropriate credentials
- Required [IAM policies](https://docs.oracle.com/en/cloud/paas/nosql-cloud/ttxsq/index.html)

## Using with Terraform

This module is compatible with OpenTofu. To use Terraform instead of OpenTofu, ensure you have Terraform installed and use the following provider configuration:

```hcl

terraform {
  required_providers {
    oci = {
      source = "oracle/oci"
      version = ">= 6.31.0"
    }
  }
}

```

## Deploy using OpenTofu or Terraform

1. Use `terraform.tfvars` File

   The repository includes a terraform.tfvars.example file. Edit it and replace the placeholder values with your actual OCI credentials, to create your own terraform.tfvars file.
   
3. To deploy the resources, initialize and apply the configuration:

```sh
tofu init  # or terraform init
tofu plan  # or terraform plan
tofu apply # or terraform apply
```

## Cleanup
To destroy the created resources, use:

```sh
tofu destroy # or terraform destroy
```
## License
This project is licensed under the MIT License - see the [LICENSE](https://github.com/angeline-hilda/OCI-nosql/blob/master/LICENSE) file for details.
