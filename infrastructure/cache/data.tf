#data.tf
data "oci_core_vcns" "parent_vcn" {
  compartment_id = "${var.compartment_ocid}"
  filter { name = "id" values = [ "${var.vcn_ocid}" ] }
}

data "oci_core_instance_pool_instances" "memcached_instances" {
  compartment_id = "${var.compartment_ocid}"
  instance_pool_id = "${oci_core_instance_pool.memcached_instance_pool.id}"
}

data "oci_core_vnic_attachments" "memcached_instances_vnic_attachments" {
  compartment_id = "${var.compartment_ocid}"
  instance_id = "${data.oci_core_instance_pool_instances.memcached_instances.instances.0.id}"
}

data "oci_core_vnic" "memcached_instances_vnics" {
  vnic_id = "${data.oci_core_vnic_attachments.memcached_instances_vnic_attachments.vnic_attachments.0.vnic_id}"
}

output "memcached_ips" { value = "${data.oci_core_vnic.memcached_instances_vnics.private_ip_address}" }
