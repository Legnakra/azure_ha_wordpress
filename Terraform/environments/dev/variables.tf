# Variables generales
variable "location" {
  type        = string
  description = "Location of the resources"
  default     = "westeurope"
}

variable "common_tags" {
  type = map(string)
  default = {
    "entorno"   = "dev"
    "autor"     = "Maria Jesus Alloza"
    "proyecto"  = "WordPress en alta disponibilidad"
    "curso"     = "2º ASIR"
    "instituto" = "IES Gonzalo Nazareno"
  }
}

# Variables del grupo de recursos
variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
  default     = "rg-hawordpress-westeu-001"
}

# Variables de networking
variable "vnet_name" {
  type        = string
  description = "Name of the virtual network"
  default     = "vnet-hawordpress-westeu-001"
}

variable "subnet_backend_name" {
  type        = string
  description = "Name of the subnet for the backend"
  default     = "snet-backend-hawordpress-westeu-001"
}

variable "subnet_database_name" {
  type        = string
  description = "Name of the subnet for the database"
  default     = "snet-database-hawordpress-westeu-001"
}

variable "lb_pip_name" {
  type        = string
  description = "Name of the public IP for the load balancer"
  default     = "pip-lb-hawordpress-westeu-001"
}

variable "nsg_name" {
  type        = string
  description = "Name of the network security group"
  default     = "nsg-hawordpress-westeu-001"
}

# Variables de las maquinas virtuales
variable "primary_vm_nic_name" {
  type        = string
  description = "Name of the primary network interface"
  default     = "nic-primary-hawordpress-westeu-001"
}

variable "secondary_vm_nic_name" {
  type        = string
  description = "Name of the secondary network interface"
  default     = "nic-secondary-hawordpress-westeu-001"
}

variable "primary_vm_name" {
  type        = string
  description = "Name of the primary virtual machine"
  default     = "vm-primary-hawordpress-westeu-001"
}

variable "secondary_vm_name" {
  type        = string
  description = "Name of the secondary virtual machine"
  default     = "vm-secondary-hawordpress-westeu-001"
}

variable "vm_size" {
  type        = string
  description = "Size of the primary virtual machine"
  default     = "Standard_B1s"
}

variable "primary_availability_zone" {
  type        = string
  description = "Availability zone of the primary virtual machine"
  default     = "1"
}

variable "secondary_availability_zone" {
  type        = string
  description = "Availability zone of the secondary virtual machine"
  default     = "2"
}

variable "primary_vm_hostname" {
  type        = string
  description = "Hostname of the primary virtual machine"
  default     = "hawordpress-001"
}

variable "secondary_vm_hostname" {
  type        = string
  description = "Hostname of the secondary virtual machine"
  default     = "hawordpress-002"
}

variable "vm_username" {
  type        = string
  description = "Username of the virtual machines"
  default     = "hawordpress"
}

variable "vm_password" {
  type        = string
  description = "Password of the virtual machines"
  default     = "$Hawordpress2023"
}

# Variables de la base de datos
variable "mysql_server_name" {
  type        = string
  description = "Name of the MySQL server"
  default     = "mysql-hawordpress-westeu-001"
}

variable "mysql_database_name" {
  type        = string
  description = "Name of the MySQL database"
  default     = "wordpress"
}

variable "mysql_username" {
  type        = string
  description = "Administrator username for the MySQL server"
  default     = "hawordpress"
}

variable "mysql_password" {
  type        = string
  description = "Administrator password for the MySQL server"
  default     = "$HaWordpre33@!"
}

# Variables de la cuenta de almacenamiento
variable "diagnostics_storage_account_name" {
  type    = string
  default = "stahawordpressdiag001"
}

# Variables del balanceador de carga
variable "load_balancer_name" {
  type        = string
  description = "Name of the load balancer"
  default     = "lb-hawordpress-westeu-001"
}