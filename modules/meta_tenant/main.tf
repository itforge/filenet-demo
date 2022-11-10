variable "name" {}
variable "location" {}
variable "cloudprovider" {}

module "azure_tenant" {
  source   = "../azure_tenant"
  count    = var.cloudprovider == "azure" ? 1 : 0
  name     = var.name
  location = var.location
}
