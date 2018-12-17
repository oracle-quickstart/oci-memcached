data "oci_core_vcns" "parent_vcn" {
  compartment_id = "${var.compartment_ocid}"
  filter { name = "id" values = [ "${var.vcn_ocid}" ] }
}

data "oci_core_vnic_attachments" "bastion1_vnic_attachment" {
  compartment_id = "${var.compartment_ocid}"
  instance_id = "${oci_core_instance.bastion1_vm.id}"
}

data "oci_core_vnic" "bastion1_vnic" {
  vnic_id = "${data.oci_core_vnic_attachments.bastion1_vnic_attachment.vnic_attachments.0.vnic_id}"
}

output "bastion_ip" { value = "${data.oci_core_vnic.bastion1_vnic.public_ip_address}" }
