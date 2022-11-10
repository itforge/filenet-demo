module "azure_omgeving" {
  source              = "../azure_omgeving"
  count                = var.cloudprovider == "azure" ? 1 : 0
  name                = "vnet-${var.name}"
  resource_group_name = var.resource_group_name
  location            = var.location
  address_space       = var.address_space
}

module "odc_omgeving" {
  source              = "../odc_omgeving"
  count                = var.cloudprovider == "odc" ? 1 : 0
  name                = "${var.name}"
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

variable "cloudprovider" {
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
