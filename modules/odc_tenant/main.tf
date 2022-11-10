variable "name" {}
variable "location" {}

resource "null_resource" "tenant" {
  triggers = {
    value = var.name
  }

  provisioner "local-exec" {
    command = <<EOT
      echo "Create tenant ${var.name}"
    EOT
  }
}
