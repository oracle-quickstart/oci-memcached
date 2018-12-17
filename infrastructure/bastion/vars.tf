# vars.tf
## Input Variables
variable "vcn_ocid" {}
variable "vcn_igw_ocid" {}
variable "compartment_ocid" {}
variable "vcn_subnet_cidrs" { type="list" default = [] }
variable "ads" { type="list" default = [] }
variable "compute_image_ocid" {}
