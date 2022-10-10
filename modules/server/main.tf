variable "name" {}
variable "location" {}
variable "resource_group_name" {}
variable "subnet" {}
variable "size" {}
variable "aantal" {}
variable "publisher" {}
variable "offer" {}
variable "sku" {}
variable "admin_user" {
    type = string
    default = "adminuser"
}

resource "tls_private_key" "ssh" {
  algorithm = "RSA"
  rsa_bits  = "4096"
}

resource "azurerm_network_interface" "nic" {
  count               = var.aantal
  name                = "${var.name}-${count.index}"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "server" {
  count               = var.aantal
  name                = "${var.name}-${count.index}"
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = var.size
  admin_username      = var.admin_user
  network_interface_ids = [
    azurerm_network_interface.nic[count.index].id,
  ]

  admin_ssh_key {
    username   = var.admin_user
    public_key = tls_private_key.ssh.public_key_openssh
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = var.publisher
    offer     = var.offer
    sku       = var.sku
    version   = "latest"
  }

  tags = {
    applicationrole = var.name
  }
}

# resource "ansible_host" "server" {
#   count              = var.aantal
#   inventory_hostname = azurerm_linux_virtual_machine.server[count.index].public_ip_address
#   groups             = ["filenet"]

#   vars = {
#     ansible_user       = var.admin_user
#   }
# }