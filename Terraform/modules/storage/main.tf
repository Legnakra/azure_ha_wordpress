# Definir la cuenta de almacenamiento para diagnostico de VM's y consola serie 
resource "azurerm_storage_account" "vm_diagnostics" {
  name                     = var.diagnostics_storage_account_name
  location                 = var.location
  resource_group_name      = var.resource_group_name
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = var.common_tags
}