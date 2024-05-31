variable "rg_names" {
  type    = list(string)
  default = ["rg1", "rg2", "rg3"]
}

resource "azurerm_resource_group" "rg" {
  for_each = toset(var.rg_names)
  name     = each.key
  location = "East US"
}
