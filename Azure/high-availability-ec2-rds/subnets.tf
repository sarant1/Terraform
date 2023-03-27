
# Public Subnets

resource "azurerm_subnet" "high_availablity_subnet_1" {
    name = "high-availability-subnet-1"
    resource_group_name  = azurerm_resource_group.high_availabability_resource_group.name
    virtual_network_name = azurerm_virtual_network.high_availability_network.name
    address_prefixes     = ["10.13.1.0/24"]

}

resource "azurerm_subnet" "high_availablity_subnet_2" {
    
    name = "high-availability-subnet-2"
    resource_group_name  = azurerm_resource_group.high_availabability_resource_group.name
    virtual_network_name = azurerm_virtual_network.high_availability_network.name
    address_prefixes     = ["10.13.2.0/24"]
}

resource "azurerm_subnet" "high_availablity_subnet_3" {
    
    name = "high-availability-subnet-3"
    resource_group_name  = azurerm_resource_group.high_availabability_resource_group.name
    virtual_network_name = azurerm_virtual_network.high_availability_network.name
    address_prefixes     = ["10.13.3.0/24"]
}

# Private Subnets


resource "azurerm_subnet" "high_availablity_subnet_4" {
    
    name = "high-availability-subnet-4"
    resource_group_name  = azurerm_resource_group.high_availabability_resource_group.name
    virtual_network_name = azurerm_virtual_network.high_availability_network.name
    address_prefixes     = ["10.13.4.0/24"]

}

resource "azurerm_subnet" "high_availablity_subnet_5" {
    
    name = "high-availability-subnet-5"
    resource_group_name  = azurerm_resource_group.high_availabability_resource_group.name
    virtual_network_name = azurerm_virtual_network.high_availability_network.name
    address_prefixes     = ["10.13.5.0/24"]
}

resource "azurerm_subnet" "high_availablity_subnet_6" {
    
    name = "high-availability-subnet-6"
    resource_group_name  = azurerm_resource_group.high_availabability_resource_group.name
    virtual_network_name = azurerm_virtual_network.high_availability_network.name
    address_prefixes     = ["10.13.6.0/24"]
}