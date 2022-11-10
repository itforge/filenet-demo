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

resource "null_resource" "dns" {
    count = var.aantal

    triggers = {
        value = var.name
    }

    provisioner "local-exec" {
        command = <<EOT
            echo "Create server ${var.name}-${count.index}"
        EOT
    }
}
