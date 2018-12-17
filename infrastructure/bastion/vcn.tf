# memcached.tf
resource "oci_core_route_table" "bastion_rt" {
  compartment_id = "${var.compartment_ocid}"
  vcn_id = "${var.vcn_ocid}"
  route_rules {
    destination_type = "CIDR_BLOCK"
    destination = "0.0.0.0/0"
    network_entity_id = "${var.vcn_igw_ocid}"
  }
  display_name = "bastion-rt"
}
resource "oci_core_security_list" "bastion_sl" {
  compartment_id = "${var.compartment_ocid}"
  vcn_id = "${var.vcn_ocid}"
  egress_security_rules = [
    { stateless="true" destination="${data.oci_core_vcns.parent_vcn.virtual_networks.0.cidr_block}" protocol="all" },
    { stateless="false" destination="0.0.0.0/0" protocol="all" }
  ]
  ingress_security_rules = [
    { stateless="true" source="${data.oci_core_vcns.parent_vcn.virtual_networks.0.cidr_block}" protocol="all" },
    { stateless="false" source="0.0.0.0/0" protocol="6" tcp_options { min=22 max=22 } }
  ]
  display_name = "bastion-sl"
}
# subnets
resource "oci_core_subnet" "bastion_ad1_net" {
  compartment_id = "${var.compartment_ocid}"
  vcn_id = "${var.vcn_ocid}"
  display_name = "bastion-ad1-net"
  availability_domain = "${var.ads[0]}"
  cidr_block = "${var.vcn_subnet_cidrs[0]}"
  route_table_id = "${oci_core_route_table.bastion_rt.id}"
  security_list_ids = [ "${oci_core_security_list.bastion_sl.id}" ]
  dhcp_options_id = "${data.oci_core_vcns.parent_vcn.virtual_networks.0.default_dhcp_options_id}"
  prohibit_public_ip_on_vnic = "false"
  dns_label = "bastion1"
}
