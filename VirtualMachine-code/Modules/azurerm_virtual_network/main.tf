resource "azurerm_virtual_network" "vv-vnet" {
  name                = var.virtual_network_name
  location            = var.rg_location
  resource_group_name = var.rg_name
  address_space       = var.address_space
}
