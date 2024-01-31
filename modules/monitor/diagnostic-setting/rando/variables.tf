variable "resource_id" {
  type = string
}
variable "log_analytics_workspace_id" {
  type    = string
  default = null
}
variable "storage_account_id" {
  type    = string
  default = null
}
variable "logs" {
  type    = list(any)
  default = []
}
variable "metrics" {
  type    = list(any)
  default = ["AllMetrics"]
}