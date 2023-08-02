resource "azurerm_resource_group" "hub" {
  name     = "rg-${var.name}"
  location = var.hub_location
}

module "log_analytics_workspace" {

  source = "../../../modules/monitor/log-analytics/workspace"

  name                = var.name
  resource_group_name = azurerm_resource_group.hub.name
  location            = azurerm_resource_group.hub.location
}

module "collection_rule" {

  source = "../../../modules/monitor/data-collection/rule/linux-shim"

  name                       = "dcr-${var.name}"
  resource_group_id          = azurerm_resource_group.hub.id
  location                   = azurerm_resource_group.hub.location
  log_analytics_workspace_id = module.log_analytics_workspace.id

}

locals {
  spoke_map = { for idx, element in var.spoke_locations : element => idx }
}

module "collection_endpoint" {

  for_each = local.spoke_map

  source = "../../../modules/monitor/data-collection/endpoint/linux"

  name                = "dce-${var.name}-${each.key}"
  resource_group_name = azurerm_resource_group.hub.name
  location            = each.key

}