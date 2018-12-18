#data.tf
data "oci_core_vcns" "parent_vcn" {
  compartment_id = "${var.compartment_ocid}"
  filter { name = "id" values = [ "${var.vcn_ocid}" ] }
}

data "oci_core_instance_pool_instances" "memcached_instances" {
  compartment_id = "${var.compartment_ocid}"
  instance_pool_id = "${oci_core_instance_pool.memcached_instance_pool.id}"
}

data "oci_core_instance" "instance" {
  count = "${var.instance_pool_size}"
  instance_id = "${lookup(data.oci_core_instance_pool_instances.memcached_instances.instances[count.index], "id")}"
}

output "memcached_ips" { value = "${data.oci_core_instance.instance.*.private_ip}" }
