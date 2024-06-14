variable "tenant_name" {
  type    = string
  description = "Name of the tenant, respectivelly the organization"
}

variable "subnet_name" {
  type    = string
  description = "Name of the subnet"
}

variable "resource_group_location" {
  type    = string
  description = "Location of the resources"
}

variable "resource_group_name" {
  type    = string
  description = "Name of the resource group, which contains the resources"
}