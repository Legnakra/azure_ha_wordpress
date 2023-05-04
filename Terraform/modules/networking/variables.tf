variable "location" {
  type        = string
  description = "Location of the resources"
}

variable "common_tags" {
  type        = map(string)
  description = "Common tags for all resources"
}


variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "vnet_name" {
  type        = string
  description = "Name of the virtual network"
}

variable "subnet_backend_name" {
  type        = string
  description = "Name of the subnet for the backend"
}

variable "lb_pip_name" {
  type        = string
  description = "Name of the public IP for the load balancer"
}

variable "nsg_name" {
  type        = string
  description = "Name of the network security group"
}