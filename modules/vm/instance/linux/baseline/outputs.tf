output "id" {
  value = azurerm_linux_virtual_machine.main.id
}
output "hostname" {
  value = azurerm_linux_virtual_machine.main.computer_name
}
output "private_ip_address" {
  value = azurerm_linux_virtual_machine.main.private_ip_address
}
output "fault_domain" {
  value = var.fault_domain
}
output "zone" {
  value = var.zone
}
output "location" {
  value = azurerm_linux_virtual_machine.main.location
}