variable "location" {
  type = string
}
variable "name" {
  type = string
}
variable "resource_group_name" {
  type = string
}
variable "address_space" {
  type    = string
  default = "10.0.0.0/22"
}