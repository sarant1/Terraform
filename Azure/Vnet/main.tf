provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "my_resource_group" {
  name     = "my_resource_group"
  location = "East US"
}

resource "azurerm_network_security_group" "my_security_group" {
  name                = "my-security-group"
  location            = azurerm_resource_group.my_resource_group.location
  resource_group_name = azurerm_resource_group.my_resource_group.name
}

resource "azurerm_public_ip" "my_public_ip" {
  name                = "my-public-ip"
  resource_group_name = azurerm_resource_group.my_resource_group.name
  location            = azurerm_resource_group.my_resource_group.location
  allocation_method   = "Static"

  tags = {
    environment = "Testing"
  }
}

resource "azurerm_network_interface" "my_nic" {
  name                = "my-nic"
  location            = azurerm_resource_group.my_resource_group.location
  resource_group_name = azurerm_resource_group.my_resource_group.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.my_subnet_1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.my_public_ip.id
  }
}

resource "azurerm_virtual_network" "my_virtual_network" {
  name                = "my-virtual-network"
  location            = azurerm_resource_group.my_resource_group.location
  resource_group_name = azurerm_resource_group.my_resource_group.name
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]

  # I am creating seperate subnet resource so I can connect it to my azure_network_interface

  #  subnet {
  #   name           = "subnet1"
  #   address_prefix = "10.0.1.0/24"
  #   security_group = azurerm_network_security_group.my_security_group.id
  # }

  # subnet {
  #   name           = "subnet2"
  #   address_prefix = "10.0.2.0/24"
  #   security_group = azurerm_network_security_group.my_security_group.id
  # }

  tags = {
    environment = "My Virtual Network Test"
  }
}

resource "azurerm_subnet" "my_subnet_1" {
  name                 = "my-subnet-1"
  resource_group_name  = azurerm_resource_group.my_resource_group.name
  virtual_network_name = azurerm_virtual_network.my_virtual_network.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "my_subnet_2" {
  name                 = "my-subnet-2"
  resource_group_name  = azurerm_resource_group.my_resource_group.name
  virtual_network_name = azurerm_virtual_network.my_virtual_network.name
  address_prefixes     = ["10.0.2.0/24"]
}



resource "azurerm_linux_virtual_machine" "my_virtual_machine" {
  name                = "my-virtual-machine"
  resource_group_name = azurerm_resource_group.my_resource_group.name
  location            = azurerm_resource_group.my_resource_group.location
  size                = "Standard_B1ms"
  admin_username      = "sudosam"
  network_interface_ids = [
    azurerm_network_interface.my_nic.id,
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