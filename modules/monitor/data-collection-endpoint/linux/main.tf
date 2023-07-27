resource "azurerm_monitor_data_collection_endpoint" "main" {
  name                          = "mdce-${var.name}"
  resource_group_name           = var.resource_group_name
  location                      = var.location
  kind                          = "Linux"
  public_network_access_enabled = true
  description                   = var.description
}