# data.tf
data "oci_identity_availability_domains" "ads" {
  compartment_id = "${var.tenancy_ocid}"
}
locals {
  ad1 = "${lookup(data.oci_identity_availability_domains.ads.availability_domains[0], "name")}"
  ad2 = "${lookup(data.oci_identity_availability_domains.ads.availability_domains[1], "name")}"
  ad3 = "${lookup(data.oci_identity_availability_domains.ads.availability_domains[2], "name")}"
}
data "oci_core_images" "oracle_linux_image" {
  compartment_id = "${var.tenancy_ocid}"
  display_name = "Oracle-Linux-7.6-2018.11.19-0"
}
locals  {
  oracle_linux_image_ocid = "${data.oci_core_images.oracle_linux_image.images.0.id}"
}
output "oracle_linux_image_ocid_output" { value = "${local.oracle_linux_image_ocid}" }
