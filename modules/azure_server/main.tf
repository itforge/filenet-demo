variable "name" {}
variable "domain" {}
variable "location" {}
variable "cloudprovider" {}
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

resource "azurerm_dns_a_record" "dns" {
  count               = var.aantal
  name                = "${var.name}-${count.index}"
  zone_name           = var.domain
  resource_group_name = var.resource_group_name
  ttl                 = 300
  target_resource_id  = azurerm_public_ip.public_ip[count.index].id
}

resource "azurerm_public_ip" "public_ip" {
  count               = var.aantal
  name                = "${var.name}-${count.index}"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Dynamic"
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
    public_ip_address_id          = azurerm_public_ip.public_ip[count.index].id
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
  tags = {
    applicationrole = "${var.name}"
  }

  admin_ssh_key {
    username   = var.admin_user
    public_key = file("${path.module}/jenkins.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = lookup(lookup(var.Azure_serverOS, var.os),"os_disk")
  }

  source_image_reference {
    publisher = lookup(lookup(var.Azure_serverOS, var.os),"publisher")
    offer     = lookup(lookup(var.Azure_serverOS, var.os),"offer")
    sku       = lookup(lookup(var.Azure_serverOS, var.os),"sku")
    version   = lookup(lookup(var.Azure_serverOS, var.os),"version")
  }

}

output "hostname" {
  value = azurerm_dns_a_record.dns.*.fqdn
}

# resource "ansible_host" "server" {
#   count              = var.aantal
#   inventory_hostname = azurerm_linux_virtual_machine.server[count.index].public_ip_address
#   groups             = ["filenet"]

#   vars = {
#     ansible_user       = var.admin_user
#   }
# }