# modules.tf

module "cache" {
  source = "cache"
  compartment_ocid = "${var.compartment_ocid}"
  vcn_ocid = "${oci_core_virtual_network.solution_vcn.id}"
  vcn_subnet_cidrs = [ "10.1.10.0/24", "10.1.11.0/24" ]
  ads = [ "${local.ad1}", "${local.ad2}" ]
}
output "memcached_ips" { value = "${module.cache.memcached_ips}" }
