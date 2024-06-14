#we created resource so we define resource block
#to create varaibles the block name will be varaibles
variable "business_devision" {
  description = "business devision on large organization"
  type        = string #list of string #map
}

variable "environment" {
  description = "environment varaibles used as prefix"
  type        = string
}

variable "resource_group_name" {
  type    = string
}

variable "resource_group_location" {
  type    = string
}

variable "vnet_name" {
  type    = string
  
}

variable "vnet_address_space" {
  type    = list(string) #it is an array format
}

variable "web_subnet_name" {
  type    = string
}

variable "web_subnet_address" {
  type    = list(string)
}