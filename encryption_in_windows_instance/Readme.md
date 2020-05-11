Using OCI cloud native services to encrypt the windows password using terraform script 
And creating 2 users for accessing the same windows instance

Here in this Usecase OCI vaukt service is used for creating vault and keys and the information about vaukt and keys are being used in the terraform script for encryption of the windows login password. The password will not be available in te terraform script 

When 2 users are created each of the user's password will be provided at the runtime and that password gets encrypted by the key information provided in the terraform script.one user will be having all the adminstrative rights while the other user will only be used for any remote installation purposes.