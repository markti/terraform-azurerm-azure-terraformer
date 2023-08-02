resource "azurerm_virtual_machine_extension" "main" {
  name                       = "DependencyAgentLinux"
  virtual_machine_id         = var.virtual_machine_id
  publisher                  = "Microsoft.Azure.Monitoring.DependencyAgent"
  type                       = "DependencyAgentLinux"
  type_handler_version       = "9.10"
  automatic_upgrade_enabled  = true
  auto_upgrade_minor_version = true

  settings = jsonencode({
    enableAMA = var.azure_monitor_agent_enabled
  })
}