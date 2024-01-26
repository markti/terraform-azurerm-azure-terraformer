module "regions" {
  source          = "Azure/regions/azurerm"
  version         = "0.5.1"
  use_cached_data = true
}

locals {
  matches = [
    for v in module.regions.regions_by_geography_group[var.geography_group] : v
  ]
}

resource "random_shuffle" "us_region" {
  input        = [for v in local.matches : v.name]
  result_count = var.quantity
}