variable "name" {}
variable "location" {}

resource "azurerm_resource_group" "tenant" {
  name     = var.name
  location = var.location
}
