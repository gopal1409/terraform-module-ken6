#how to create a resource group. 
#how to create a resource group. 

resource "azurerm_virtual_network" "vnet" {
  name = "${local.resource_name_prefix}-${var.vnet_name}"
  #this vnet need to be part of your resource group and resource group location
  location            = var.resource_group_name
  resource_group_name = var.resource_group_location
  address_space       = var.vnet_address_space

  tags = local.common_tags

}
resource "azurerm_subnet" "web_subnet" {
  name                 = "${local.resource_name_prefix}-${var.web_subnet_name}"
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.resource_group_location
  address_prefixes     = var.web_subnet_address
}

#local block start with locals
locals {
  owners               = var.business_devision
  environment          = var.environment
  resource_name_prefix = "${var.business_devision}-${var.environment}"
  #sap-dev
  common_tags = {
    owners      = local.owners
    environment = local.environment
  }
}