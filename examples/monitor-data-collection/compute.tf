resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}


module "vm1" {

  source = "../../modules/vm/instance/linux/baseline"

  hostname            = "vm${var.name}${random_string.name.result}01"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  vm_size             = "Standard_D4s_v5"
  admin_username      = "azureuser"
  admin_ssh_key       = tls_private_key.ssh_key.public_key_openssh
  subnet_id           = module.westus_network.main_subnet_id
  system_assigned_id  = true

  source_image_reference = {
    publisher = "canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts-gen2"
    version   = "latest"
  }
}

resource "azurerm_monitor_data_collection_rule_association" "vm1" {

  target_resource_id      = module.vm1.id
  data_collection_rule_id = module.westus_monitor.data_collection_rule_id
  name                    = "${module.vm1.hostname}-VMInsights-Dcr-Association"
  description             = "Association of data collection rule for VM Insights."

}


module "vm2" {

  source = "../../modules/vm/instance/linux/baseline"

  hostname            = "vm${var.name}${random_string.name.result}02"
  resource_group_name = azurerm_resource_group.main.name
  location            = "eastus"
  vm_size             = "Standard_D4s_v5"
  admin_username      = "azureuser"
  admin_ssh_key       = tls_private_key.ssh_key.public_key_openssh
  subnet_id           = module.eastus_network.main_subnet_id
  system_assigned_id  = true

  source_image_reference = {
    publisher = "canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts-gen2"
    version   = "latest"
  }
}

resource "azurerm_monitor_data_collection_rule_association" "vm2" {

  target_resource_id      = module.vm2.id
  data_collection_rule_id = module.eastus_monitor.data_collection_rule_id
  name                    = "${module.vm2.hostname}-VMInsights-Dcr-Association"
  description             = "Association of data collection rule for VM Insights."

}