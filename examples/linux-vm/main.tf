resource "random_string" "name" {
  length  = 8
  special = false
  upper   = false
}

resource "azurerm_resource_group" "main" {
  name     = "rg-${var.name}-${random_string.name.result}-vms"
  location = var.location
}

module "network" {
  source = "../modules/simple-network"

  name                = "${var.name}-${random_string.name.result}-westus"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

}

module "vm1" {

  source = "../../modules/vm/instance/linux/baseline"

  hostname            = "vm${var.name}${random_string.name.result}01"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  vm_size             = "Standard_D4s_v5"
  admin_username      = "azureuser"
  admin_ssh_key       = tls_private_key.ssh_key.public_key_openssh
  subnet_id           = module.network.main_subnet_id
  system_assigned_id  = true

  source_image_reference = {
    publisher = "canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts-gen2"
    version   = "latest"
  }

  depends_on = [azurerm_storage_account.main]
}
