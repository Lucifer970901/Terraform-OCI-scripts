# Oracle Cloud Infrastructure Terraform Module for OCI Cache with Redis 

This Terraform configuration provisions an OCI Redis Cluster with monitoring and alarms using OCI Monitoring Service. The setup includes:

- Redis Cluster: Deployed in a private subnet.
- VCN and Subnets:
  - Private subnet for Redis Database.
  - Public subnet for Jump Server (to access Redis securely).
- Jump server with Redis client installed. 
- Monitoring & Alarms: Alerts on various metrics for OCI Cache using OCI Monitoring Service.

## Pre-requisites

Ensure you have the following before using this module:

- [OpenTofu](https://opentofu.org/docs/intro/install/) or [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli) installed
- An Oracle Cloud Infrastruture(OCI) Account
- [Configure OCI CLI](https://docs.oracle.com/en-us/iaas/Content/dev/terraform/tutorials/tf-provider.htm#prepare) with appropriate credentials
- Required IAM policies for [OCI cache](https://docs.oracle.com/en-us/iaas/Content/ocicache/permissions.htm) and [OCI Monitoring](https://docs.oracle.com/en-us/iaas/scanning/using/metrics-prereq.htm)

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
## Connecting to Redis via Jump Server

1. SSH into the Jump Server:
   ```
   ssh -i <ssh-privatekey> opc@<jumpserver-public-ip>
   ```
2. From the Jump Server, connect to Redis:
   ```
   redis-cli --tls -h <oci-cache_node-endpoint>
   ```

## Connect using Redis Insight
Install Redis Insight on your local laptop and connect to OCI Cache with Redis.
1. Install [Redis Insight](https://redis.io/insight/?utm_source=redisinsight&utm_medium=website&utm_campaign=install_redisinsight#insight-form)
2. Add the credentials to connect to the OCI Cache with Redis.
   - **Host**: Enter cluster node endpoint
   - **Port**: Enter **6379**
3. Enter the Bastion/Jump Server public IP address as Host and Port will be 22. Redis Insight will use the Jump Server in the public subnet using SSH to access the OCI Cache with Redis database.
<img src="https://github.com/user-attachments/assets/8132edfa-6950-4366-8894-3362b8351f7d" width="800"/>
<img src="https://github.com/user-attachments/assets/0d339c22-33ad-4c58-b59e-ec571780cb2d" width="800"/>

## Documentation
- [OCI Cache with Redis](https://docs.public.oneportal.content.oci.oraclecloud.com/en-us/iaas/Content/ocicache/overview.htm#ocicacheoverview)
- [OCI Monitoring](https://docs.oracle.com/en-us/iaas/Content/Monitoring/Concepts/monitoringoverview.htm)
- [OCI Notifications](https://docs.oracle.com/en-us/iaas/Content/Notification/Concepts/notificationoverview.htm)
- [OCI Cache Metrics](https://docs.oracle.com/en-us/iaas/Content/ocicache/metrics.htm)
- [MQL Reference](https://docs.oracle.com/en-us/iaas/Content/Monitoring/Reference/mql.htm)

## License
This project is licensed under the MIT License - see the [LICENSE](https://github.com/angeline-hilda/OCI-Terraform-redis/blob/main/LICENSE) file for details.
