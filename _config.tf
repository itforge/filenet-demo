# Specify providers
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.23.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "rg-prod"
    storage_account_name = "itftfstate"
    container_name       = "tfstate"
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}
