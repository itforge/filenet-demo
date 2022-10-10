# Specify providers
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.23.0"
    }
    ansible = {
      source = "nbering/ansible"
      version = "1.0.4"
    }
  }
  backend "azurerm" {
    resource_group_name  = "rg-prod"
    storage_account_name = "itftfstate"
    key                  = "terraform.tfstate"
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}
