# data.tf
data "oci_identity_availability_domains" "ads" {
  compartment_id = "${var.tenancy_ocid}"
}
locals {
  ad1 = "${lookup(data.oci_identity_availability_domains.ads.availability_domains[0], "name")}"
  ad2 = "${lookup(data.oci_identity_availability_domains.ads.availability_domains[1], "name")}"
  ad3 = "${lookup(data.oci_identity_availability_domains.ads.availability_domains[2], "name")}"
}
