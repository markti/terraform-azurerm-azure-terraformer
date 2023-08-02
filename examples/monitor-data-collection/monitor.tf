module "westus_monitor" {
  source = "../modules/regional-logs"

  name     = "${var.name}-${random_string.name.result}-westus"
  location = "westus"

}

module "eastus_monitor" {
  source = "../modules/regional-logs"

  name     = "${var.name}-${random_string.name.result}-eastus"
  location = "eastus"

}

module "westus_monitor2" {
  source = "../modules/regional-logs"

  name     = "${var.name}-${random_string.name.result}-clicky"
  location = "westus"

}