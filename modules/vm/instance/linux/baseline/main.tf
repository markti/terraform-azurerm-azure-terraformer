
locals {
  clean_hostname                   = lower(var.hostname)
  system_assigned_identity_enabled = var.system_assigned_id
  user_assigned_identity_enabled   = length(var.managed_identities) > 0
  identity_enabled                 = local.system_assigned_identity_enabled || local.user_assigned_identity_enabled
  system_assigned_identity_type    = local.system_assigned_identity_enabled ? "SystemAssigned" : ""
  user_assigned_identity_type      = local.user_assigned_identity_enabled ? "UserAssigned" : ""
  identity_type                    = trimspace(join(" ", [local.system_assigned_identity_type, local.user_assigned_identity_type]))
}

resource "azurerm_linux_virtual_machine" "main" {

  name                            = local.clean_hostname
  location                        = var.location
  resource_group_name             = var.resource_group_name
  size                            = var.vm_size
  computer_name                   = local.clean_hostname
  admin_username                  = var.admin_username
  network_interface_ids           = [azurerm_network_interface.main.id]
  zone                            = var.zone
  platform_fault_domain           = var.fault_domain
  proximity_placement_group_id    = var.proximity_placement_group_id
  disable_password_authentication = true
  source_image_id                 = var.vm_image_id
  virtual_machine_scale_set_id    = var.virtual_machine_scale_set_id
  availability_set_id             = var.availability_set_id
  tags                            = var.tags

  admin_ssh_key {
    username   = var.admin_username
    public_key = var.admin_ssh_key
  }

  os_disk {
    name                 = "${local.clean_hostname}-osdisk"
    caching              = var.os_disk.caching
    storage_account_type = var.os_disk.storage_account_type
    disk_size_gb         = var.os_disk.size
  }

  dynamic "source_image_reference" {
    for_each = var.vm_image_id == null ? [0] : []
    content {
      publisher = var.source_image_reference.publisher
      sku       = var.source_image_reference.sku
      offer     = var.source_image_reference.offer
      version   = var.source_image_reference.version
    }
  }

  dynamic "identity" {
    for_each = local.identity_enabled ? [1] : []
    content {
      type         = local.identity_type
      identity_ids = var.managed_identities
    }
  }
}
