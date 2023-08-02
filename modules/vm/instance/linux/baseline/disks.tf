locals {

}

resource "azurerm_managed_disk" "data" {

  count = var.data_disks.count

  name                 = "${local.clean_hostname}-data${count.index}"
  location             = var.location
  resource_group_name  = var.resource_group_name
  storage_account_type = var.data_disks.storage_account_type
  create_option        = "Empty"
  disk_size_gb         = var.data_disks.size
}

resource "azurerm_virtual_machine_data_disk_attachment" "data" {

  count = var.data_disks.count

  managed_disk_id    = azurerm_managed_disk.data[count.index].id
  virtual_machine_id = azurerm_linux_virtual_machine.main.id
  lun                = count.index + 10
  caching            = var.data_disks.caching
}

resource "azurerm_managed_disk" "log" {

  count = var.log_disks.count

  name                 = "${local.clean_hostname}-log${count.index}"
  location             = var.location
  resource_group_name  = var.resource_group_name
  storage_account_type = var.data_disks.storage_account_type
  create_option        = "Empty"
  disk_size_gb         = var.log_disks.size

}

resource "azurerm_virtual_machine_data_disk_attachment" "log" {

  count = var.log_disks.count

  managed_disk_id    = azurerm_managed_disk.log[count.index].id
  virtual_machine_id = azurerm_linux_virtual_machine.main.id
  lun                = count.index + 20
  caching            = var.log_disks.caching

}
