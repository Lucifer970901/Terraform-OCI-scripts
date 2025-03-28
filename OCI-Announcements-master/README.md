# Oracle Cloud Infrastructure Terraform Module for Announcements 

This repository contains Terraform modules which provisions and configures Oracle Cloud Infrastructure (OCI) Announcements Subscription, allowing users to receive OCI service updates and announcements via an OCI Notifications topic.


## Features

- Creates an Announcements Subscription for tenancy-wide notifications.
- Supports language and timezone preferences for announcements.
- Optionally applies filters to receive only specific announcement types.


## Pre-requisites

Ensure you have the following before using this module:

- [OpenTofu](https://opentofu.org/docs/intro/install/) or [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli) installed
- An Oracle Cloud Infrastruture(OCI) Account
- [Configure OCI CLI](https://docs.oracle.com/en-us/iaas/Content/dev/terraform/tutorials/tf-provider.htm#prepare) with appropriate credentials
- Required [IAM Policies](https://docs.oracle.com/en-us/iaas/Content/General/Concepts/announcements.htm#permissions)


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
- [OCI Announcements](https://docs.oracle.com/en-us/iaas/Content/General/Concepts/announcements.htm)
- [OCI Notifications](https://docs.oracle.com/en-us/iaas/Content/Notification/Concepts/notificationoverview.htm)

## License
This project is licensed under the MIT License - see the [LICENSE](https://github.com/angeline-hilda/OCI-Announcements/blob/master/LICENSE) file for details.
