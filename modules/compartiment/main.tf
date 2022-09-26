resource "azurerm_subnet" "subnet" {
  name                 = var.name
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = var.address_prefixes
}

#Azure Subnet module variable.tf file
variable "name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "virtual_network_name" {
  type = string
}

variable "address_prefixes" {
  type = list
}

output "subnet_id" {
  value = azurerm_subnet.subnet.id
}

# output "name" {
#   value = {
#     for subnet in azurerm_subnet.subnet :
#     subnet.name => subnet.name
#   }
# }

# output "id" {
#   value = {
#     for subnet in azurerm_subnet.subnet :
#     subnet.name => subnet.id
#   }
# }