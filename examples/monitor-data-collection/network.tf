module "westus_network" {
  source = "../modules/simple-network"

  name                = "${var.name}-${random_string.name.result}-westus"
  location            = "westus"
  resource_group_name = azurerm_resource_group.main.name

}

module "eastus_network" {
  source = "../modules/simple-network"

  name                = "${var.name}-${random_string.name.result}-eastus"
  location            = "eastus"
  resource_group_name = azurerm_resource_group.main.name

}