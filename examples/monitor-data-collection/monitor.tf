module "westus_monitor" {
  source = "../modules/uniform-region"

  name     = "${var.name}-${random_string.name.result}-westus"
  location = "westus"

}

module "eastus_monitor" {
  source = "../modules/uniform-region"

  name     = "${var.name}-${random_string.name.result}-eastus"
  location = "eastus"

}
/*
# This will not work because the log analytics workspace must be in the same region as the DCR
module "hub_spoke_monitor" {
  source = "../modules/hub-and-spoke"

  name            = "${var.name}-${random_string.name.result}-hub"
  hub_location    = "centralus"
  spoke_locations = ["westus", "eastus"]

}
*/