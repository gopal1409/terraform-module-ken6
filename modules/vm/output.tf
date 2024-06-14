output "azurerm_virtual_network_name" {
    value = azurerm_virtual_network.vnet.name
}

output "azurerm_virtual_network_id" {
    value = azurerm_virtual_network.vnet.id
}

output "azurerm_subnet_id" {
    value = azurerm_subnet.subnet.id
}
