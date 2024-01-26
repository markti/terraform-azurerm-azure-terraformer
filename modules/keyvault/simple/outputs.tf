output "id" {
  value      = azurerm_key_vault.main.id
  depends_on = [azurerm_key_vault_access_policy.terraform_user]
}