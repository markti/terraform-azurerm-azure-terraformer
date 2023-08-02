output "bastion_subnet_id" {
  value = azurerm_subnet.bastion.id
}
output "main_subnet_id" {
  value = azurerm_subnet.default.id
}