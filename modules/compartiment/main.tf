resource "azurerm_subnet" "subnet" {
  count                = var.cloudprovider == "azure" ? 1 : 0
  name                 = var.name
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = var.address_prefixes
}

resource "azurerm_network_security_group" "nsg" {
  count               = var.cloudprovider == "azure" ? 1 : 0
  name                = "${var.name}-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "http"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "https"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "ssh"
    priority                   = 120
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "nsg" {
  count                     = var.cloudprovider == "azure" ? 1 : 0
  subnet_id                 = azurerm_subnet.subnet[count.index].id
  network_security_group_id = azurerm_network_security_group.nsg[count.index].id
}

#Azure Subnet module variable.tf file
variable "name" {
  type = string
}

variable "location" {
  type = string
}

variable "cloudprovider" {
  type    = string
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