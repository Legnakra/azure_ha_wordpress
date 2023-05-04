# Definir la tarjeta de red para la VM primaria
resource "azurerm_network_interface" "nic_primary_vm" {
  name                = var.primary_vm_nic_name
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "backend"
    primary                       = true
    subnet_id                     = var.backend_subnet_id
    private_ip_address_version    = "IPv4"
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.0.1.11"
  }

  tags = var.common_tags
}

# Definir la tarjeta de red para la VM secundaria
resource "azurerm_network_interface" "nic_secondary_vm" {
  name                = var.secondary_vm_nic_name
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "backend"
    primary                       = true
    subnet_id                     = var.backend_subnet_id
    private_ip_address_version    = "IPv4"
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.0.1.10"
  }

  tags = var.common_tags
}

# Definir la VM primaria
resource "azurerm_linux_virtual_machine" "primary_vm" {
  name                = var.primary_vm_name
  location            = var.location
  resource_group_name = var.resource_group_name
  zone                = var.primary_availability_zone
  size                = var.vm_size

  network_interface_ids = [
    azurerm_network_interface.nic_primary_vm.id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts-gen2"
    version   = "latest"
  }

  computer_name                   = var.primary_vm_hostname
  admin_username                  = var.vm_username
  admin_password                  = var.vm_password
  disable_password_authentication = false

  boot_diagnostics {
    storage_account_uri = var.diagnostics_storage_account_endpoint
  }

  tags = var.common_tags
}

# Definir la VM secundaria
resource "azurerm_linux_virtual_machine" "secondary_vm" {
  name                = var.secondary_vm_name
  location            = var.location
  resource_group_name = var.resource_group_name
  zone                = var.secondary_availability_zone
  size                = var.vm_size

  network_interface_ids = [
    azurerm_network_interface.nic_secondary_vm.id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts-gen2"
    version   = "latest"
  }

  computer_name                   = var.secondary_vm_hostname
  admin_username                  = var.vm_username
  admin_password                  = var.vm_password
  disable_password_authentication = false

  boot_diagnostics {
    storage_account_uri = var.diagnostics_storage_account_endpoint
  }

  tags = var.common_tags
}

# Asociar reglas de seguridad de red a las tarjetas de red
resource "azurerm_network_interface_security_group_association" "primary_nic_association" {
  network_interface_id      = azurerm_network_interface.nic_primary_vm.id
  network_security_group_id = var.lb_security_group_id
}

resource "azurerm_network_interface_security_group_association" "secondary_nic_association" {
  network_interface_id      = azurerm_network_interface.nic_secondary_vm.id
  network_security_group_id = var.lb_security_group_id
}