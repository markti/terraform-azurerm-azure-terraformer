module "regions" {
  source  = "Azure/regions/azurerm"
  version = "0.5.1"
}

locals {
  us_regions = [for region in module.regions : region if region.geography_group == var.geography_group]
}

# Random selection
resource "random_shuffle" "us_region" {
  input        = [for region in local.us_regions : region.name]
  result_count = 1
}