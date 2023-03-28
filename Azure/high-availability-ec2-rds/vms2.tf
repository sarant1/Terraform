resource "azurerm_network_interface" "nic_2" {
  name                = "nic-2"
  location            = var.azure_region
  resource_group_name = azurerm_resource_group.high_availabability_resource_group.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.high_availablity_subnet_2.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.public_ip_2.id
  }
}

resource "azurerm_public_ip" "public_ip_2" {
  name                = "HA-public-ip-2"
  resource_group_name = azurerm_resource_group.high_availabability_resource_group.name
  location            = var.azure_region
  allocation_method   = "Static"

  tags = {
    environment = "Production"
  }
}


resource "azurerm_linux_virtual_machine" "vm_2" {
  name                = "vm-2"
  resource_group_name = azurerm_resource_group.high_availabability_resource_group.name
  location            = var.azure_region
  size                = "Standard_B1ms"
  admin_username      = "sudosam"
  network_interface_ids = [
    azurerm_network_interface.nic_2.id
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