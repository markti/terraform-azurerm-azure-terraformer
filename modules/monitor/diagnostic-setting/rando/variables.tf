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
variable "retention_period" {
  type        = number
  default     = null
  description = "The number of days to retain logs. By default, if not specified, no retention policy is set."
}