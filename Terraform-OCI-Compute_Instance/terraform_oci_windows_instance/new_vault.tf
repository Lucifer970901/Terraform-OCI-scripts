#get availability_domain
data "oci_identity_availability_domain" "ad" {
 compartment_id = "${var.tenancy_ocid}"
ad_number = "${var.availability_domain}"
}

#get the oci vault details
data "oci_kms_vault" "test_vault" {
  #Required
  vault_id = "${var.vault_id}"
}

#get key details
data "oci_kms_key" "test_key" {
  #Required
  key_id              = "${var.key_id}"
  management_endpoint = "${var.management_endpoint}"
}

#encrypt the data suing the key imported
  resource "oci_kms_encrypted_data" "test_encrypted_data" {
      #Required
      crypto_endpoint = "${var.crypto_endpoint}"
      key_id = "${data.oci_kms_key.test_key.id}"
      plaintext = base64encode("${var.ansible_password}")
}

#decrypts the data
data "oci_kms_decrypted_data" "test_decrypted_data" {
    #Required
    ciphertext = "${oci_kms_encrypted_data.test_encrypted_data.ciphertext}"
    crypto_endpoint = "${var.crypto_endpoint}"
    key_id          = "${data.oci_kms_key.test_key.id}"
    }
