# Configurar el provider de Azure
provider "azurerm" {
  features {}
}

# Configuracion del backend local
terraform {
  backend "local" {
    path = "../../backends/dev/terraform.tfstate"
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.53.0"
    }
  }
}

# Llamada al modulo de creacion del Grupo de Recursos
module "resource_group" {
  source              = "../../modules/resource-group"
  location            = var.location
  common_tags         = var.common_tags
  resource_group_name = var.resource_group_name
}

# Llamada al modulo de creacion de la cuenta de almacenamiento
module "storage" {
  source                           = "../../modules/storage"
  location                         = var.location
  common_tags                      = var.common_tags
  resource_group_name              = module.resource_group.resource_group_name
  diagnostics_storage_account_name = var.diagnostics_storage_account_name
}

# Llamada al modulo de creacion de recursos de networking
module "networking" {
  source              = "../../modules/networking"
  location            = var.location
  common_tags         = var.common_tags
  resource_group_name = module.resource_group.resource_group_name
  vnet_name           = var.vnet_name
  subnet_backend_name = var.subnet_backend_name
  lb_pip_name         = var.lb_pip_name
  nsg_name            = var.nsg_name
}

# Llamada al modulo de creacion de la base de datos
module "database" {
  source              = "../../modules/database"
  location            = var.location
  common_tags         = var.common_tags
  resource_group_name = module.resource_group.resource_group_name
  mysql_server_name   = var.mysql_server_name
  mysql_database_name = var.mysql_database_name
  mysql_username      = var.mysql_username
  mysql_password      = var.mysql_password
}

# Llamada al modulo de creacion de las maquinas virtuales
module "virtual-machines" {
  source                               = "../../modules/virtual-machines"
  location                             = var.location
  common_tags                          = var.common_tags
  resource_group_name                  = module.resource_group.resource_group_name
  primary_vm_nic_name                  = var.primary_vm_nic_name
  secondary_vm_nic_name                = var.secondary_vm_nic_name
  primary_vm_name                      = var.primary_vm_name
  secondary_vm_name                    = var.secondary_vm_name
  vm_size                              = var.vm_size
  primary_availability_zone            = var.primary_availability_zone
  secondary_availability_zone          = var.secondary_availability_zone
  primary_vm_hostname                  = var.primary_vm_hostname
  secondary_vm_hostname                = var.secondary_vm_hostname
  vm_username                          = var.vm_username
  vm_password                          = var.vm_password
  backend_subnet_id                    = module.networking.backend_subnet_id
  diagnostics_storage_account_endpoint = module.storage.diagnostics_storage_account_endpoint
  lb_security_group_id                 = module.networking.lb_security_group_id
}

# Llamada al modulo de creacion del balanceador de carga
module "load-balancer" {
  source                                 = "../../modules/load-balancer"
  location                               = var.location
  common_tags                            = var.common_tags
  resource_group_name                    = module.resource_group.resource_group_name
  load_balancer_name                     = var.load_balancer_name
  lb_pip_id                              = module.networking.lb_pip_id
  primary_vm_nic_id                      = module.virtual-machines.primary_vm_nic_id
  secondary_vm_nic_id                    = module.virtual-machines.secondary_vm_nic_id
  primary_vm_nic_ip_configuration_name   = module.virtual-machines.primary_vm_nic_ip_configuration_name
  secondary_vm_nic_ip_configuration_name = module.virtual-machines.secondary_vm_nic_ip_configuration_name
  depends_on = [ module.virtual-machines, module.networking ]
}