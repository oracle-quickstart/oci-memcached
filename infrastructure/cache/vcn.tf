# memcached.tf
resource "oci_core_nat_gateway" "cache_ngw" {
  compartment_id = "${var.compartment_ocid}"
  vcn_id = "${var.vcn_ocid}"
  display_name = "cache-ngw"
}
resource "oci_core_route_table" "cache_rt" {
  compartment_id = "${var.compartment_ocid}"
  vcn_id = "${var.vcn_ocid}"
  route_rules {
    destination_type = "CIDR_BLOCK"
    destination = "0.0.0.0/0"
    network_entity_id = "${oci_core_nat_gateway.cache_ngw.id}"
  }
  display_name = "cache-rt"
}
resource "oci_core_security_list" "cache_sl" {
  compartment_id = "${var.compartment_ocid}"
  vcn_id = "${var.vcn_ocid}"
  egress_security_rules = [
    { stateless="true" destination="${data.oci_core_vcns.parent_vcn.virtual_networks.0.cidr_block}" protocol="all" },
    { stateless="false" destination="0.0.0.0/0" protocol="all" }
  ]
  ingress_security_rules = [
    { stateless="true" source="${data.oci_core_vcns.parent_vcn.virtual_networks.0.cidr_block}" protocol="6" tcp_options { min=22 max=22 } },
    { stateless="true" source="${data.oci_core_vcns.parent_vcn.virtual_networks.0.cidr_block}" protocol="6" tcp_options { min=11211 max=11211 } }
  ]
  display_name = "cache-sl"
}
# subnets
resource "oci_core_subnet" "cache_ad1_net" {
  compartment_id = "${var.compartment_ocid}"
  vcn_id = "${var.vcn_ocid}"
  display_name = "cache-ad1-net"
  availability_domain = "${var.ads[0]}"
  cidr_block = "${var.vcn_subnet_cidrs[0]}"
  route_table_id = "${oci_core_route_table.cache_rt.id}"
  security_list_ids = [ "${oci_core_security_list.cache_sl.id}" ]
  dhcp_options_id = "${data.oci_core_vcns.parent_vcn.virtual_networks.0.default_dhcp_options_id}"
  prohibit_public_ip_on_vnic = "true"
  dns_label = "cache1"
}
resource "oci_core_subnet" "cache_ad2_net" {
  compartment_id = "${var.compartment_ocid}"
  vcn_id = "${var.vcn_ocid}"
  display_name = "cache-ad2-net"
  availability_domain = "${var.ads[1]}"
  cidr_block = "${var.vcn_subnet_cidrs[1]}"
  route_table_id = "${oci_core_route_table.cache_rt.id}"
  security_list_ids = [ "${oci_core_security_list.cache_sl.id}" ]
  dhcp_options_id = "${data.oci_core_vcns.parent_vcn.virtual_networks.0.default_dhcp_options_id}"
  prohibit_public_ip_on_vnic = "true"
  dns_label = "cache2"
}
