variable "common_tags" {
  type        = map(string)
  description = "Common tags for all resources"
}

variable "location" {
  type        = string
  description = "Location of the resources"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "load_balancer_name" {
  type        = string
  description = "Name of the load balancer"
}

variable "lb_pip_id" {
  type        = string
  description = "ID of the public IP for the load balancer"
}

variable "primary_vm_nic_id" {
  type        = string
  description = "ID of the primary network interface"
}

variable "secondary_vm_nic_id" {
  type        = string
  description = "ID of the secondary network interface"
}

variable "primary_vm_nic_ip_configuration_name" {
  type        = string
  description = "Name of the primary network interface IP configuration"
}

variable "secondary_vm_nic_ip_configuration_name" {
  type        = string
  description = "Name of the secondary network interface IP configuration"
}