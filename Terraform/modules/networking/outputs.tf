output "backend_subnet_id" {
  value = azurerm_subnet.backend.id
}

output "lb_pip_name" {
  value = azurerm_public_ip.lb_pip.name
}

output "lb_pip_id" {
  value = azurerm_public_ip.lb_pip.id
}

output "lb_security_group_id" {
  value = azurerm_network_security_group.lb_nsg.id
}