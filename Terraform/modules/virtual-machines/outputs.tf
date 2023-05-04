output "primary_vm_nic_id" {
  value = azurerm_network_interface.nic_primary_vm.id
}

output "secondary_vm_nic_id" {
  value = azurerm_network_interface.nic_secondary_vm.id
}

output "primary_vm_nic_ip_configuration_name" {
  value = azurerm_network_interface.nic_primary_vm.ip_configuration[0].name
}

output "secondary_vm_nic_ip_configuration_name" {
  value = azurerm_network_interface.nic_secondary_vm.ip_configuration[0].name
}