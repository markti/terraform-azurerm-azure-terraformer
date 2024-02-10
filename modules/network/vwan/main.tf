resource "azurerm_virtual_wan" "main" {
  name                = "vwan-${var.name}"
  resource_group_name = var.resource_group_name
  location            = var.location
}

resource "azurerm_virtual_hub" "primary" {
  name                = "vhub-${var.name}-primary"
  resource_group_name = var.resource_group_name
  location            = var.location
  virtual_wan_id      = azurerm_virtual_wan.main.id
  address_prefix      = var.primary_address_prefix
}

resource "azurerm_virtual_hub" "additional_regions" {

  for_each = var.additional_regions

  name                = "vhub-${var.name}-${each.key}"
  resource_group_name = var.resource_group_name
  location            = each.key
  virtual_wan_id      = azurerm_virtual_wan.main.id
  address_prefix      = each.value

}