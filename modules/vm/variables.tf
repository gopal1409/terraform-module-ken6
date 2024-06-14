variable "my_virtual_machine_name" {
  type        = string
  description = "Name of the Virtual Machine"
}

variable "my_virtual_machine_password" {
  type        = string
  description = "Password of the Virtual Machine"
}

variable "my_virtual_machine_size" {
  type        = string
  description = "Size of the Virtual Machine"
}

variable "location" {
  type         = string
  description  = "Location of the resources"
}

variable "resource_group_name" {
  type          = string
  description   = "Name of the resource group, which contains the resources"
}

variable "azurerm_subnet_id" {
  description   = "Id of the subnet"
}

variable "source_image_offer" {
  description   = "Source image offer of the virtual machine"
}

variable "source_image_sku" {
  description   = "Source image offer of the virtual machine"
}

variable "network_interface_name" {
  description   = "Name of the network interface"
}

variable "public_ip_address_name" {
  description   = "Name of the public ip address"
}