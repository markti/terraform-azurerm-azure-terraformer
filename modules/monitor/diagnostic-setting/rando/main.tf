resource "random_string" "random" {
  length  = 8
  special = false
  lower   = true
  upper   = false
}

module "main" {

  source = "../base"

  name                       = random_string.random.result
  resource_id                = var.resource_id
  log_analytics_workspace_id = var.log_analytics_workspace_id
  storage_account_id         = var.storage_account_id
  logs                       = var.logs
  metrics                    = var.metrics
  retention_period           = var.retention_period

}