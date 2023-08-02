module "dependency_agent" {

  source                      = "../../../extension/linux/dependency-agent"
  virtual_machine_id          = azurerm_linux_virtual_machine.main.id
  azure_monitor_agent_enabled = true

}

module "azure_monitor" {

  source             = "../../../extension/linux/azure-monitor"
  virtual_machine_id = azurerm_linux_virtual_machine.main.id

  depends_on = [
    module.dependency_agent
  ]

}