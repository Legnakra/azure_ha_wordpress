variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "location" {
  type        = string
  description = "Location of the resource group"
}

variable "common_tags" {
  type        = map(string)
  description = "Common tags for all resources"
}