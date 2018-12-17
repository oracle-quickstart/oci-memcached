# modules.tf

module "cache" {
  source = "cache"
  compartment_ocid = "${var.compartment_ocid}"
  vcn_ocid = "${oci_core_virtual_network.solution_vcn.id}"
  vcn_subnet_cidrs = [ "10.1.10.0/24", "10.1.11.0/24" ]
  ads = [ "${local.ad1}", "${local.ad2}" ]
  compute_image_ocid = "${local.oracle_linux_image_ocid}"
  instance_pool_size = 2
}

module "bastion" {
  source = "bastion"
  compartment_ocid = "${var.compartment_ocid}"
  vcn_ocid = "${oci_core_virtual_network.solution_vcn.id}"
  vcn_igw_ocid = "${oci_core_internet_gateway.solution_igw.id}"
  vcn_subnet_cidrs = [ "10.1.20.0/24" ]
  ads = [ "${local.ad1}", "${local.ad2}", "${local.ad3}" ]
  compute_image_ocid = "${local.oracle_linux_image_ocid}"
}
