resource "random_string" "name" {
  length  = 8
  special = false
  upper   = false
}

resource "azurerm_resource_group" "main" {
  name     = "rg-${var.name}-${random_string.name.result}-vms"
  location = var.location
}
