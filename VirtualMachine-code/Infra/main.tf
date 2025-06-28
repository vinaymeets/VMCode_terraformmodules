module "azurerm_resource_group" {
  source      = "../Modules/azurerm_resouce_group"
  rg_name     = "RG-VV"
  rg_location = "West US"
}

module "azurerm_virtual_network" {
  depends_on = [module.azurerm_resource_group]

  source = "../Modules/azurerm_virtual_network"

  virtual_network_name = "vnet-xxx"
  rg_location          = "West US"
  rg_name              = "RG-VV"
  address_space        = ["10.0.0.0/16"]
}

module "subnet1" {
  depends_on  = [module.azurerm_virtual_network]
  source      = "../Modules/azurerm_subnet"
  subnet_name = "frontend-subnet"
  rg_name     = "RG-VV"
  vnet_name   = "vnet-xxx"
  subnet_ip   = ["10.0.1.0/24"]
}
module "subnet2" {
  depends_on  = [module.azurerm_virtual_network]
  source      = "../Modules/azurerm_subnet"
  subnet_name = "backend-subnet"
  rg_name     = "RG-VV"
  vnet_name   = "vnet-xxx"
  subnet_ip   = ["10.0.2.0/24"]
}

module "frontend_pip" {

  depends_on  = [module.azurerm_resource_group]
  source      = "../Modules/azurerm_public_IP"
  pip_name    = "xxx-frontendpip"
  rg_name     = "RG-VV"
  rg_location = "West US"
}

module "backend_pip" {

  depends_on  = [module.azurerm_resource_group]
  source      = "../Modules/azurerm_public_IP"
  pip_name    = "backendpip"
  rg_name     = "RG-VV"
  rg_location = "West US"
}

module "frontend_vm" {

  depends_on = [module.azurerm_resource_group, module.azurerm_virtual_network, module.subnet1, module.frontend_pip]

  source = "../Modules/azurerm_virtual_machine"

  vm_name              = "frondendvm"
  rg_name              = "RG-VV"
  rg_location          = "West US"
  public_ip            = "xxx-frontendpip"
  nic_name             = "frontend_nic"
  username             = "adminuser"
  password             = "Admin@123456"
  subnet_name          = "frontend-subnet"
  virtual_network_name = "vnet-xxx"
}

module "backend_vm" {

  depends_on = [module.azurerm_resource_group, module.azurerm_virtual_network, module.subnet2, module.backend_pip]

  source = "../Modules/azurerm_virtual_machine"

  vm_name              = "backendvm"
  rg_name              = "RG-VV"
  rg_location          = "West US"
  public_ip            = "backendpip"
  nic_name             = "backend_nic"
  username             = "adminuser"
  password             = "Admin@123456"
  subnet_name          = "backend-subnet"
  virtual_network_name = "vnet-xxx"
}

module "sqlserver" {

  depends_on = [module.azurerm_resource_group]
  source     = "../Modules/azurerm_sql_server"

  servername   = "xxxsqlserver"
  rg_name      = "RG-VV"
  rg_location  = "West US"
  sql_username = "sqladmin"
  sql_password = "Admin@123456"
}

module "sqldatabase" {
  depends_on = [module.sqlserver]
  source       = "../Modules/azurerm_sql_database"
  sql_database = "xxxsqldatabase"
  servername   = "xxxsqlserver"
  rg_name      = "RG-VV"

}
