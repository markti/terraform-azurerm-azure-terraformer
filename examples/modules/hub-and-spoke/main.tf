resource "azurerm_resource_group" "hub" {
  name     = "rg-${var.name}-hub"
  location = var.hub_location
}

module "log_analytics_workspace" {

  source = "../../../modules/monitor/log-analytics/workspace"

  name                = var.name
  resource_group_name = azurerm_resource_group.hub.name
  location            = azurerm_resource_group.hub.location
}

locals {
  spoke_map = { for idx, element in var.spoke_locations : element => idx }
}

module "collection_rule" {

  for_each = local.spoke_map

  source = "../../../modules/monitor/data-collection/rule/linux-shim"

  name                       = "dcr-${var.name}-${each.key}"
  resource_group_id          = azurerm_resource_group.hub.id
  location                   = each.key
  log_analytics_workspace_id = module.log_analytics_workspace.id

}