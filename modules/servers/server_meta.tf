module "azure_server" {
    source               = ./modules/azure_server
    count                = var.cloudprovider == "azure" ? 1 : 0
    name                 = var.name
    location             = var.region
    aantal               = each.value.aantal
    resource_group_name  = module.omgeving.rg_name
    subnet               = module.compartiment[each.value.compartiment].subnet_id
    size                 = each.value.size
    publisher            = each.value.os
}

module "odc_server" {
    source               = ./modules/odc_server
    count                = var.cloudprovider == "odc" ? 1 : 0

}
