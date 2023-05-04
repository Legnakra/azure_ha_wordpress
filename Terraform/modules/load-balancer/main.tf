# Definir el balanceador de carga
resource "azurerm_lb" "wordpress_lb" {
  name                = var.load_balancer_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "wp-frontend"
    public_ip_address_id = var.lb_pip_id
  }

  tags = var.common_tags
}

resource "azurerm_lb_backend_address_pool" "wordpress_backend_pool" {
  name            = "wp-backend"
  loadbalancer_id = azurerm_lb.wordpress_lb.id
}

resource "azurerm_lb_probe" "wordpress_lb_probe" {
  name            = "web-probe"
  protocol        = "Tcp"
  port            = 80
  loadbalancer_id = azurerm_lb.wordpress_lb.id
}

resource "azurerm_lb_probe" "wordpress_lb_ssl_probe" {
  name            = "https-probe"
  protocol        = "Tcp"
  port            = 443
  loadbalancer_id = azurerm_lb.wordpress_lb.id
}

resource "azurerm_lb_rule" "wordress_lb_rule" {
  name                           = "http-rule"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  load_distribution              = "SourceIPProtocol"
  frontend_ip_configuration_name = azurerm_lb.wordpress_lb.frontend_ip_configuration[0].name
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.wordpress_backend_pool.id]
  probe_id                       = azurerm_lb_probe.wordpress_lb_probe.id
  loadbalancer_id                = azurerm_lb.wordpress_lb.id
}

resource "azurerm_lb_rule" "wordress_lb_ssl_rule" {
  name                           = "https-rule"
  protocol                       = "Tcp"
  frontend_port                  = 443
  backend_port                   = 443
  load_distribution              = "SourceIPProtocol"
  frontend_ip_configuration_name = azurerm_lb.wordpress_lb.frontend_ip_configuration[0].name
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.wordpress_backend_pool.id]
  probe_id                       = azurerm_lb_probe.wordpress_lb_ssl_probe.id
  loadbalancer_id                = azurerm_lb.wordpress_lb.id
}

resource "azurerm_network_interface_backend_address_pool_association" "primary_nic_association" {
  network_interface_id    = var.primary_vm_nic_id
  ip_configuration_name   = var.primary_vm_nic_ip_configuration_name
  backend_address_pool_id = azurerm_lb_backend_address_pool.wordpress_backend_pool.id
}

resource "azurerm_network_interface_backend_address_pool_association" "secondary_nic_association" {
  network_interface_id    = var.secondary_vm_nic_id
  ip_configuration_name   = var.secondary_vm_nic_ip_configuration_name
  backend_address_pool_id = azurerm_lb_backend_address_pool.wordpress_backend_pool.id
}