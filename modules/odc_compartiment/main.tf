resource "null_resource" "subnet" {
  triggers = {
    value = var.name
  }

  provisioner "local-exec" {
    command = <<EOT
      echo "Create compartiment ${var.name}"
    EOT
  }
}

variable "name" {}
variable "location" {}
variable "resource_group_name" {}
variable "virtual_network_name" {}
variable "address_prefixes" {
    type = list
}

output "subnet_id" {
  value = null_resource.subnet.id
}
