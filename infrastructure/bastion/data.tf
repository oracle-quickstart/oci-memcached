data "oci_core_vcns" "parent_vcn" {
  compartment_id = "${var.compartment_ocid}"
  filter { name = "id" values = [ "${var.vcn_ocid}" ] }
}

output "bastion_ips" { value = "${data.oci_core_vcns.parent_vcn.virtual_networks.0.cidr_block}" }
