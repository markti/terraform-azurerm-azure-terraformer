resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}


module "vm" {

  source = "../../modules/vm/instance/linux/baseline"

  hostname            = "vm${var.name}${random_string.name.result}01"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  vm_size             = "Standard_D4s_v5"
  admin_username      = "azureuser"
  admin_ssh_key       = tls_private_key.ssh_key.public_key_openssh
  subnet_id           = azurerm_subnet.default.id
  system_assigned_id  = true

  source_image_reference = {
    publisher = "canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts-gen2"
    version   = "latest"
  }
}

resource "azurerm_monitor_data_collection_rule_association" "vm" {

  target_resource_id      = module.vm.id
  data_collection_rule_id = module.westus_monitor.data_collection_rule_id
  name                    = "${module.vm.hostname}-VMInsights-Dcr-Association"
  description             = "Association of data collection rule for VM Insights."

}
