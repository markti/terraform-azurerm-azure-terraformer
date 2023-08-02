variable "name" {
  type = string
}
variable "hub_location" {
  type = string
}
variable "spoke_locations" {
  type = list(string)
}