Hello All!.

There would be various scenarios which would want us to deploy the resources in various regions at a time. This can be done using terraform!
here is the usecase where we are trying to deploy the vcn within a new compartment using terraform.
here, the compartment requires to be created in the home region, and we are creating the VCN in another region, how can this be achieved?
we need to make use of Alias in terraform.
Alias can be used to define multiple terraform provider configuarations. we define the configuaration for home region and then another configuaration for the region where we want to deploy resources.
Here is the example on how to define configuaration using Alias.

provider "oci" {
  alias            = "home"
  region           = var.region
  tenancy_ocid     = var.tenancy_ocid
  user_ocid        = var.user_ocid
  fingerprint      = var.fingerprint
  private_key_path = var.private_key_path
}

provider "oci" {
  alias            = "region2"
  region           = var.region2
  tenancy_ocid     = var.tenancy_ocid
  user_ocid        = var.user_ocid
  fingerprint      = var.fingerprint
  private_key_path = var.private_key_path
}
Define the variables for both the regions in the variables file of terraform.
I have also used the “time_sleep” resource to make sure the compartment is up and running before we create the VCN within it.
 please follow the script to understand more on deployment.
here is the output,
 ![image](https://user-images.githubusercontent.com/26675416/133198045-c42d5b53-5517-43e8-96c1-5f0e745af815.png)

Hope this helps, Happy learning!
