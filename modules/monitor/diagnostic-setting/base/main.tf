resource "azurerm_monitor_diagnostic_setting" "main" {

  name                       = "${var.prefix}${var.name}"
  target_resource_id         = var.resource_id
  log_analytics_workspace_id = var.log_analytics_workspace_id
  storage_account_id         = var.storage_account_id

  dynamic "enabled_log" {
    for_each = var.logs
    content {
      category = log.value
    }
  }

  dynamic "metric" {
    for_each = var.metrics
    content {
      category = metric.value
      enabled  = true
    }
  }
}