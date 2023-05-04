variable "location" {
  type        = string
  description = "Location of the resources"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "common_tags" {
  type        = map(string)
  description = "Common tags for all resources"
}

variable "primary_vm_nic_name" {
  type        = string
  description = "Name of the primary network interface"
}

variable "secondary_vm_nic_name" {
  type        = string
  description = "Name of the secondary network interface"
}

variable "backend_subnet_id" {
  type        = string
  description = "ID of the subnet for the backend"
}

variable "primary_vm_name" {
  type        = string
  description = "Name of the primary virtual machine"
}

variable "secondary_vm_name" {
  type        = string
  description = "Name of the secondary virtual machine"
}

variable "vm_size" {
  type        = string
  description = "Size of the primary virtual machine"
}

variable "primary_availability_zone" {
  type        = string
  description = "Availability zone of the primary virtual machine"
}

variable "secondary_availability_zone" {
  type        = string
  description = "Availability zone of the secondary virtual machine"
}

variable "primary_vm_hostname" {
  type        = string
  description = "Hostname of the primary virtual machine"
}

variable "secondary_vm_hostname" {
  type        = string
  description = "Hostname of the secondary virtual machine"
}

variable "vm_username" {
  type        = string
  description = "Username of the virtual machines"
}

variable "vm_password" {
  type        = string
  description = "Password of the virtual machines"
}

variable "diagnostics_storage_account_endpoint" {
  type        = string
  description = "Endpoint of the storage account for VM diagnostics"
}

variable "lb_security_group_id" {
  type        = string
  description = "ID of the Load Balancer network security group"
}