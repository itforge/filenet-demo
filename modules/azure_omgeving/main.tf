resource "azurerm_virtual_network" "vnet" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  address_space       = var.address_space
}

output "vnet_name" {
    value = var.name
}

output "rg_name" {
    value = var.resource_group_name
}

variable "name" {
  type    = string
}

variable "resource_group_name" {
  type    = string
}

variable "location" {
  type    = string
  default = "West Europe"
}

variable "address_space" {
  type    = list(any)
}
