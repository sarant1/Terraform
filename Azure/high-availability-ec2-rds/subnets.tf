
resource "azurerm_subnet" "high_availablity_subnet_1" {
    name = "high-availability-subnet-0"
    resource_group_name  = azurerm_resource_group.high_availabability_resource_group.name
    virtual_network_name = azurerm_virtual_network.high_availability_network.name
    address_prefixes     = ["10.13.0.0/24"]

}

resource "azurerm_subnet" "high_availablity_subnet_2" {
    
    name = "high-availability-subnet-1"
    resource_group_name  = azurerm_resource_group.high_availabability_resource_group.name
    virtual_network_name = azurerm_virtual_network.high_availability_network.name
    address_prefixes     = ["10.13.1.0/24"]
}

resource "azurerm_subnet" "high_availablity_subnet_3" {
    
    name = "high-availability-subnet-2"
    resource_group_name  = azurerm_resource_group.high_availabability_resource_group.name
    virtual_network_name = azurerm_virtual_network.high_availability_network.name
    address_prefixes     = ["10.13.2.0/24"]
}
