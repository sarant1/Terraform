resource "azurerm_network_interface" "nic_1" {
  name                = "nic-1"
  location            = var.azure_region
  resource_group_name = azurerm_resource_group.high_availabability_resource_group.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.high_availablity_subnet_1.id
    private_ip_address_allocation = "Dynamic"
  }
}


resource "azurerm_linux_virtual_machine" "vm_1" {
  name                = "vm-1"
  resource_group_name = azurerm_resource_group.high_availabability_resource_group.name
  location            = var.azure_region
  size                = "Standard_B1ms"
  admin_username      = "sudosam"
  network_interface_ids = [
    azurerm_network_interface.nic_1.id
  ]

  admin_ssh_key {
    username   = "sudosam"
    public_key = file("~/.ssh/azure_vm_1.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-LTS"
    version   = "latest"
  }
}