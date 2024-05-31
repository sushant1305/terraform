terraform {
  required_version = ">=1.8"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
    ansible = {
      source  = "ansible/ansible"
      version = "~>1.3"
    }
  }
}
provider "azurerm" {
  features {}
}
