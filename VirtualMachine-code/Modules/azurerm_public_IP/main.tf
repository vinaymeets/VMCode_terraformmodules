resource "azurerm_public_ip" "vmpip" {
  name = var.pip_name
  location = var.rg_location
  resource_group_name = var.rg_name
  allocation_method = "Static"
  sku = "Standard"
  }