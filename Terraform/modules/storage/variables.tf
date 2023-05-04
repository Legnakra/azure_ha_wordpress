variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "location" {
  type        = string
  description = "Location of the resources"
}

variable "common_tags" {
  type        = map(string)
  description = "Common tags for all resources"
}

variable "diagnostics_storage_account_name" {
  type        = string
  description = "Name of the storage account for VM diagnostics"
}