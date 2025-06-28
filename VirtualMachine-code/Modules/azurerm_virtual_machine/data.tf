data "azurerm_public_ip" "data_publicip" {
  name                = var.public_ip
  resource_group_name = var.rg_name
}

data "azurerm_subnet" "data_subnet" {
  name                 = var.subnet_name
  virtual_network_name = var.virtual_network_name
  resource_group_name  = var.rg_name
}