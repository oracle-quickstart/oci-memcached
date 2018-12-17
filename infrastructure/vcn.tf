# vcn.tf
resource "oci_core_virtual_network" "solution_vcn" {
  compartment_id = "${var.compartment_ocid}"
  cidr_block = "${var.vcn_cidr}"
  display_name = "solution-vcn"
  dns_label = "vcn"
}
resource "oci_core_internet_gateway" "solution_igw" {
  compartment_id = "${var.compartment_ocid}"
  vcn_id = "${oci_core_virtual_network.solution_vcn.id}"
}
