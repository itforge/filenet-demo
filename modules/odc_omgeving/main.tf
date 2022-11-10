resource "null_resource" "omgeving" {
  triggers = {
    value = var.name
  }

  provisioner "local-exec" {
    command = <<EOT
      echo "Create omgeving ${var.name}"
    EOT
  }
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
