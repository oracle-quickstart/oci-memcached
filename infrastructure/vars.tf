# vars.tf
## Input Variables
variable "tenancy_ocid" {}
variable "user_ocid" {}
variable "region" {}
variable "private_key_path" {}
variable "fingerprint" {}
variable "private_key_password" {}
variable "compartment_ocid" {}

#
variable "vcn_cidr" { type = "string" default = "10.1.0.0/16" }
