# Terraform
this repository contains whatever I tried out  and traouble shooting which was done using terraform for the oracle provider
This is for the terraform version 12.
this can be considered as a beginer guide(hands on)
This particular config file is for resources such as VCN, subnet(both private and public), Internet gateway, Route table with route rules, security lists.

Introduction
We will discuss the use of infrastructure as a code software to deploy Oracle Linux within Oracle Cloud Infrastructure. Infrastructure as a code is a process where data center computing can be provisioned using machine-readable definition files. Infrastructure as a code can replace traditional tools and techniques such as manual systems administration and interactive UI and command line. Terraform is open-source software that allows users to define complex data center infrastructure in a high-level configuration language used within a supported public cloud using API’s.

Oracle Linux provisioning with Oracle Cloud Infrastructure and Terraform
For Oracle Linux 7, installing Terraform is easy: simply enable ol7_developer yum channel, then run yum install terraform. For Oracle Linux there is no need to install the terraform-provider-oci RPM as terraform will pull in the provider if it is referenced in a *.tf file when terraform init is run. For other operating systems, download the Terraform binary and the Terraform provider for Oracle Cloud Infrastructure from here. Next, create a. terraformrc or terraform.rc file to tell Terraform where the terraform-provider-oci binary is. Once you have installed Terraform, users can create configuration files to suit their end configuration using examples and documentation here.
 
Users need to generate a RSA key pair and enter their public key as an API key via the Oracle Cloud Infrastructure as explained here. Terraform uses their private key to connect to their Oracle Cloud Infrastructure tenancy. Once the files are completed and then checked via Terraform utilities, the software talks to Oracle Cloud Infrastructure via APIs and can test or dry run the desired configuration before building based upon the configuration files. Terraform keeps track of what it deploys and users can re-create entities for example removed by hand. Terraform can also remove the end configuration.

Terraform Client Installation
For Oracle Linux 7 we simply perform the following to install Terraform:
Edit /etc/yum.repos.d/public-yum-ol7.repo and if not present add the following to the file:
[ol7_developer]
    name=Oracle Linux $releasever Development Packages ($basearch)
    baseurl=http://yum.oracle.com/repo/OracleLinux/OL7/developer/$basearch/
    gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-oracle
    gpgcheck=1
    enabled=1
    If the entry does exist then change enabled=1 as per the example above.
Run: sudo yum install terraform 

As Terraform packages are frequently updated, we recommend regular yum updates to enable any new features.

sudo –i
yum install terraform
 
 
 
Create an API key for your user
mkdir ~/.oci
 
openssl genrsa -out ~/.oci/oci_api_key.pem 2048
 

Finally, we generate the public key:
openssl rsa -pubout -in ~/.oci/oci_api_key.pem -out ~/.oci/oci_api_key_public.pem
 
We can run the following command to view the fingerprint. The fingerprint of a key is a unique sequence of letters and numbers used to identify the key. Similar to a fingerprint of two people never being the same.
openssl rsa -pubout -outform DER -in ~/.oci/oci_api_key.pem | openssl md5 –c
if it doesn’t work then
openssl rsa -pubout -outform DER -in ~/.oci/oci_api_key.pem | openssl md5 -c

 
We need to cat the public key file and copy the key output, as we need this to upload the API key to Oracle Cloud Infrastructure.

cat ~/.oci/oci_api_key_public.pem
 
 
Upload the Public Key
We now need to upload the public key created in the previous step to the Oracle Cloud Infrastructure. Log into Oracle Cloud Infrastructure and follow the steps detailed here. Once you upload the key, you will see your fingerprint displayed. You can check using the command referenced above. It is possible to create and upload a maximum of three keys.

 
Click on Add Public Key
 
 
Obtain the Tenancy and User OCIDs

We need to capture these id’s to use in our configuration files. You can get the Tenancy ID from the bottom of the UI. The User OCID by clicking on your username in the top right hand corner and then selecting User Settings. Under the Create / Reset Password box, there is the truncated User OCID. You can choose to either show the User OCID or copy it. If your user is part of a compartment then we should obtain this too. For further information on compartments, refer to the documentation.

Create a Public Key for created Instances
We should create a public key when creating either bare metal or virtual instances. Reference the Oracle Linux 7 documentation.
 
Run the following command: ssh-keygen
this creates a public and private key file within the .ssh folder.
 


