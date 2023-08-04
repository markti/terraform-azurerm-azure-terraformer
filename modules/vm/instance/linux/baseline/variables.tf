variable "resource_group_name" {
  description = "The name of the resource group in which to create the virtual network."
}
variable "location" {
  description = "The location/region where the virtual network is created. Changing this forces a new resource to be created."
}
variable "fault_domain" {
  type        = number
  default     = null
  description = "Platform Fault Domain"
}
variable "zone" {
  type    = number
  default = null
}
variable "virtual_machine_scale_set_id" {
  type    = string
  default = null
}
variable "proximity_placement_group_id" {
  type    = string
  default = null
}
variable "hostname" {
  type = string
}
variable "vm_size" {
  type = string
}
variable "vm_image_id" {
  type    = string
  default = null
}
variable "source_image_reference" {
  type = object(
    {
      publisher = string
      offer     = string
      sku       = string
      version   = string
    }
  )
  default = null
}
variable "admin_username" {
  type = string
}
variable "admin_ssh_key" {
  type = string
}
variable "subnet_id" {
  type = string
}
variable "os_disk" {
  type = object({
    caching              = optional(string, "ReadOnly")
    size                 = optional(number, 128)
    storage_account_type = optional(string, "Premium_LRS")
  })
  default = {
    caching              = "ReadOnly"
    size                 = 128
    storage_account_type = "Premium_LRS"
  }
}
variable "data_disks" {
  type = object({
    count                = optional(number, 0)
    size                 = number
    caching              = optional(string, "ReadOnly")
    storage_account_type = optional(string, "Premium_LRS")
  })
  default = {
    count                = 0
    caching              = ""
    size                 = 0
    storage_account_type = ""
  }
}
variable "log_disks" {
  type = object({
    count                = optional(number, 0)
    size                 = number
    caching              = optional(string, "ReadOnly")
    storage_account_type = optional(string, "Premium_LRS")
  })
  default = {
    count                = 0
    caching              = ""
    size                 = 0
    storage_account_type = ""
  }
}
variable "system_assigned_id" {
  type    = bool
  default = false
}
variable "managed_identities" {
  type    = list(string)
  default = []
}
variable "tags" {
  type    = map(any)
  default = null
}