# compute.tf
resource "oci_core_instance" "bastion1_vm" {
  compartment_id = "${var.compartment_ocid}"
  display_name = "bastion-1-vm"
  availability_domain = "${var.ads[0]}"
  source_details {
    source_id = "${var.compute_image_ocid}"
    source_type = "image"
  }
  shape = "VM.Standard2.1"
  create_vnic_details {
    subnet_id = "${oci_core_subnet.bastion_ad1_net.id}"
    assign_public_ip = true
  }
  metadata {
    ssh_authorized_keys = "${file("~/.ssh/oci_id_rsa.pub")}"
  }
}
