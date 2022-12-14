module "tenant" {
  source        = "./modules/meta_tenant"
  cloudprovider = var.cloudprovider
  name          = var.tenant
  location      = var.region
}

module "omgeving" {
  source              = "./modules/meta_omgeving"
  name                = "${var.tenant}-${var.omgeving}"
  resource_group_name = var.tenant
  location            = var.region
  cloudprovider       = var.cloudprovider
  address_space       = var.vnet_address_space

  depends_on = [
    module.tenant
  ]
}

module "compartiment" {
  source               = "./modules/meta_compartiment"
  for_each             = var.compartimenten
  name                 = each.value.name
  virtual_network_name = module.omgeving.vnet_name
  resource_group_name  = module.omgeving.rg_name
  location             = var.region
  cloudprovider        = var.cloudprovider
  address_prefixes     = each.value.address_prefixes

  depends_on = [
    module.omgeving
  ]
}

module "servers" {
  source              = "./modules/meta_server"
  for_each            = var.servers
  name                = each.value.name
  aantal              = each.value.aantal
  resource_group_name = module.omgeving.rg_name
  location            = var.region
  cloudprovider       = var.cloudprovider
  subnet              = module.compartiment[each.value.compartiment].subnet_id[var.cloudprovider]
  size                = each.value.size
  publisher           = each.value.publisher
  offer               = each.value.offer
  sku                 = each.value.sku

  depends_on = [
    module.compartiment
  ]
}

output "hostnames" {
  value = [for x in module.servers : x.hostname]
}
