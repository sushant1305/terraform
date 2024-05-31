terraform {
  required_version = ">=1.8"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "terraformstate"
    storage_account_name = "sushanttfstate3005"
    container_name       = "tfstate"
    key                  = "state.tfstate"
  }
}

provider "azurerm" {
  features {}
}
