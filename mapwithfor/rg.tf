locals {
   vm_configurations = {
     for vm_name in var.vm_names : vm_name => {
       name     = vm_name
       location = var.resource_group_location
       vm_size  = "Standard_DS1_v2"
       username = "azureuser"
    }
  }
}

resource "random_pet" "rg_name" {
  prefix = var.resource_group_name_prefix
}

resource "azurerm_resource_group" "rg" {
  name     = random_pet.rg_name.id
  location = var.resource_group_location
}
