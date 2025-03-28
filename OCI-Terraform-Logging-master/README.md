# Oracle Cloud Infrastructure Terraform Module for Logging - Bucket Access Logs

This repository contains Terraform modules for configuring OCI Logging to capture and manage logs for various OCI services, sepcifically for Object Storage bucket access logs.

Use this module to:
- Create **Log Groups** to organzie logs
- Enable **Bucket Access Logs** to track read and write operations
- Define log definitions to control what should be logged and the log storage duration

## Pre-requisites

Ensure you have the following before using this module:

- [OpenTofu](https://opentofu.org/docs/intro/install/) or [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli) installed
- An Oracle Cloud Infrastruture(OCI) Account
- [Configure OCI CLI](https://docs.oracle.com/en-us/iaas/Content/dev/terraform/tutorials/tf-provider.htm#prepare) with appropriate credentials
- Required [IAM Policies](https://docs.oracle.com/en-us/iaas/Content/Logging/Task/managinglogs.htm#required_iam_policy)


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


## Documentation

- [Object Storage Logs](https://docs.oracle.com/en-us/iaas/Content/Logging/Reference/details_for_object_storage.htm#details_for_object_storage)
- [OCI Logs](https://docs.oracle.com/en-us/iaas/Content/Logging/Concepts/loggingoverview.htm)

## License
This project is licensed under the MIT License - see the [LICENSE](https://github.com/angeline-hilda/OCI-Terraform-Logging/blob/master/LICENSE) file for details.
