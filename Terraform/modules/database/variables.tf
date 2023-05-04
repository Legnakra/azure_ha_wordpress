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

variable "mysql_server_name" {
  type        = string
  description = "Name of the MySQL server"
}

variable "mysql_database_name" {
  type        = string
  description = "Name of the MySQL database"
}

variable "mysql_username" {
  type        = string
  description = "Administrator username for the MySQL server"
}

variable "mysql_password" {
  type        = string
  description = "Administrator password for the MySQL server"
}