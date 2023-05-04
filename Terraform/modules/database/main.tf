# Definir el servidor MySQL
resource "azurerm_mysql_server" "wp-mysql" {
  name                              = var.mysql_server_name
  location                          = var.location
  resource_group_name               = var.resource_group_name
  sku_name                          = "B_Gen5_1"
  storage_mb                        = 5120
  version                           = "8.0"
  administrator_login               = var.mysql_username
  administrator_login_password      = var.mysql_password
  auto_grow_enabled                 = false
  backup_retention_days             = 7
  geo_redundant_backup_enabled      = false
  infrastructure_encryption_enabled = false
  public_network_access_enabled     = true
  ssl_enforcement_enabled           = false
  ssl_minimal_tls_version_enforced  = "TLSEnforcementDisabled"
  tags                              = var.common_tags
}

# Definir la base de datos para Wordpress
resource "azurerm_mysql_database" "wp-mysql" {
  name                = var.mysql_database_name
  resource_group_name = var.resource_group_name
  server_name         = azurerm_mysql_server.wp-mysql.name
  charset             = "utf8"
  collation           = "utf8_general_ci"
}

# Permitir acceso al servidor desde los recursos de Azure
resource "azurerm_mysql_firewall_rule" "mysql_azure_vms" {
  name                = "azure-access"
  resource_group_name = var.resource_group_name
  server_name         = azurerm_mysql_server.wp-mysql.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "0.0.0.0"
}