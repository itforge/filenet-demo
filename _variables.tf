variable "tenant" {
  description = "Tenant naam"
  type        = string
}

variable "region" {
  description = "Region naam"
  type        = string
}

variable "provider" {
  description = "Infra Provider, odc, azure of aws"
  type        = string
}

variable "omgeving" {
  description = "Omgeving naam"
  type        = string
}

variable "compartimenten" {
  description = "Map met compartimenten"
  type = map(object({
    name             = string
    address_prefixes = list(string)
  }))
}

variable "servers" {
  description = "Map met servers"
  type = map(object({
    aantal = string
    name = string
    size = string
    compartiment = string
    publisher = string
    offer = string
    sku = string
  }))
}

variable "vnet_address_space" {
  description = "Subnet voor vnet"
  type        = list(any)
}