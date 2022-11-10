module "azure_compartiment" {
  source              = "../azure_compartiment"
  count                = var.cloudprovider == "azure" ? 1 : 0
  name                 = var.name
  virtual_network_name = var.virtual_network_name
  resource_group_name  = var.resource_group_name
  location             = var.location
  address_prefixes     = var.address_prefixes
}

module "odc_compartiment" {
  source              = "../odc_compartiment"
  count                = var.cloudprovider == "odc" ? 1 : 0
  name                 = var.name
  virtual_network_name = var.virtual_network_name
  resource_group_name  = var.resource_group_name
  location             = var.location
  address_prefixes     = var.address_prefixes
}

output "vnet_name" {
    value = var.name
}

output "rg_name" {
    value = var.resource_group_name
}

output "subnet_id" {
  value = var.cloudprovider == "azure" ? module.azure_compartiment.0.subnet_id : null
}

output "subnet_id2" {
  value = var.cloudprovider == "odc" ? module.odc_compartiment.0.subnet_id : null
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

variable "address_prefixes" {
  type    = list(any)
}

variable "virtual_network_name" {}
