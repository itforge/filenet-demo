module "azure_server" {
  source               = "../azure_server"
  count                = var.cloudprovider == "azure" ? 1 : 0
  name                 = var.name
  aantal               = var.aantal
  resource_group_name  = var.resource_group_name
  location             = var.location
  subnet               = var.subnet
  size                 = var.size
  publisher            = var.publisher
  offer                = var.offer
  sku                  = var.sku
}

module "odc_server" {
  source               = "../odc_server"
  count                = var.cloudprovider == "odc" ? 1 : 0
  name                 = var.name
  aantal               = var.aantal
  resource_group_name  = var.resource_group_name
  location             = var.location
  subnet               = var.subnet
  size                 = var.size
  publisher            = var.publisher
  offer                = var.offer
  sku                  = var.sku
}

variable "name" {}
variable "location" {}
variable "cloudprovider" {}
variable "resource_group_name" {}
variable "subnet" {}
variable "size" {}
variable "aantal" {}
variable "publisher" {}
variable "offer" {}
variable "sku" {}
