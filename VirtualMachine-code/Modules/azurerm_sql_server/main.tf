resource "azurerm_mssql_server" "sql_server" {
  name                         = var.servername
  resource_group_name          = var.rg_name
  location                     = var.rg_location
  version                      = "12.0"
  administrator_login          = var.sql_username
  administrator_login_password = var.sql_password

}
