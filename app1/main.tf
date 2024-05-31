# Creating a new resource group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.resource_group_location
}
#resource "azurerm_resource_group" "rg1" {
#  name     = "training"
#  location = "East US"
#}
