resource "random_string" "name" {
  length  = 8
  special = false
  upper   = false
}

resource "azurerm_resource_group" "main" {
  name     = "rg-${var.name}-${random_string.name.result}"
  location = var.location
}

module "log_analytics_workspace" {

  source = "../../modules/monitor/log-analytics-workspace"

  name                = "${var.name}-${random_string.name.result}"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
}