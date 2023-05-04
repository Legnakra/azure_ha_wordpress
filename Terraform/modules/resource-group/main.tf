# Definir el grupo de recursos del proyecto
resource "azurerm_resource_group" "resource-group" {
  name     = var.resource_group_name
  location = var.location
  tags = var.common_tags
}