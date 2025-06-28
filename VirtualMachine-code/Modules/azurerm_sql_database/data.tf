data "azurerm_mssql_server" "datasqlserver" {
  name                = var.servername
  resource_group_name = var.rg_name
}