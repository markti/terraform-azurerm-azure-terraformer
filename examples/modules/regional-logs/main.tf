resource "azurerm_resource_group" "main" {
  name     = "rg-${var.name}"
  location = var.location
}

module "log_analytics_workspace" {

  source = "../../modules/monitor/log-analytics/workspace"

  name                = var.name
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
}

module "collection_rule" {

  source = "../../modules/monitor/data-collection/rule/linux-shim"

  name                       = "dcr-${var.name}"
  resource_group_id          = azurerm_resource_group.main.id
  location                   = azurerm_resource_group.main.location
  log_analytics_workspace_id = module.log_analytics_workspace.id

}