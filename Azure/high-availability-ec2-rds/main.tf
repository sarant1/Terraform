
provider "azurerm" {
  features {}
}


resource "azurerm_resource_group" "high_availabability_resource_group" {
  name     = "high-availability-resource-group"
  location = var.azure_region
}

resource "azurerm_network_security_group" "high_availabability_security_group" {
  name                = "high-availability-security-group"
  location            = var.azure_region
  resource_group_name = azurerm_resource_group.high_availabability_resource_group.name
}

resource "azurerm_virtual_network" "high_availability_network" {
  name                = "high-availablity-vnet"
  location            = var.azure_region
  resource_group_name = azurerm_resource_group.high_availabability_resource_group.name
  address_space       = ["10.13.0.0/16"]
  dns_servers         = ["10.13.0.4", "10.13.0.5"]

  tags = {
    environment = "Production"
  }
}

resource "azurerm_availability_set" "high_availability_set" {
  name                = "high_availability_set"
  location            = var.azure_region
  resource_group_name = azurerm_resource_group.high_availabability_resource_group.name

  tags = {
    environment = "Production"
  }
}




