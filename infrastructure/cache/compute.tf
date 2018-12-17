# compute.tf
# instance pools
resource "oci_core_instance_configuration" "memcached_node_instance_config" {
  compartment_id = "${var.compartment_ocid}"
  instance_details {
    instance_type = "compute"
    launch_details {
      compartment_id = "${var.compartment_ocid}"
      create_vnic_details {
        assign_public_ip = "false"
      }
      metadata {
        ssh_authorized_keys = "${file("~/.ssh/oci_id_rsa.pub")}"
        user_data = "${base64encode(file("cache/cloud-init/cache-node.yaml"))}"
      }
      shape = "VM.Standard2.1"
      source_details {
        source_type = "image"
        image_id = "${var.compute_image_ocid}"
      }
    }
  }
  display_name = "memcached-node-instance-config"
}

resource "oci_core_instance_pool" "memcached_instance_pool" {
  compartment_id = "${var.compartment_ocid}"
  instance_configuration_id = "${oci_core_instance_configuration.memcached_node_instance_config.id}"
  placement_configurations = [
    {
      availability_domain = "${var.ads[0]}"
      primary_subnet_id = "${oci_core_subnet.cache_ad1_net.id}"
    },
    {
      availability_domain = "${var.ads[1]}"
      primary_subnet_id = "${oci_core_subnet.cache_ad2_net.id}"
    }
  ]
  size = "${var.instance_pool_size}"
  display_name = "memcached-instance-pool"
}
