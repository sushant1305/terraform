resource "random_id" "random_id" {
  keepers = {
    ## Generate a new id only when a new resource group is created
    resource_group = azurerm_resource_group.rg.name
  }
  byte_length = 8
}

## Create a storage account for boot diagnostic
resource "azurerm_storage_account" "my_storage_account" {
  name                     = "diag${random_id.random_id.hex}"
  location                 = azurerm_resource_group.rg.location
  resource_group_name      = azurerm_resource_group.rg.name
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
