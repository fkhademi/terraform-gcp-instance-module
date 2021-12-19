## Required Vars ##
variable "name" {
  description = "Name of the instance"
}
variable "region" {
  description = "Region to deploy the instance"
}
variable "vpc" {
  description = "VPC Name to deploy the instance in"
}
variable "subnet" {
  description = "Subnet Name to deploy the instance in"
}
variable "ssh_key" {
  description = "Public SSH key for the instance"
}

## Optional Vars ##
variable "instance_size" {
  description = "Compute instance size"
  default     = "f1-micro"
}
variable "zone" {
  description = "Availability Zome for the instance"
  default     = "b"
}

variable "public_ip" {
  description = "Set to true to assign a public IP to the instance"
  default     = false
}
