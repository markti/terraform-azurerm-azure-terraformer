variable "resource_group_name" {
  type = string
}
variable "location" {
  type = string
}
variable "name" {
  type = string
}
variable "primary_address_prefix" {
  type = string
}
variable "additional_regions" {
  type = map(string)
}