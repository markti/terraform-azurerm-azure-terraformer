
module "region" {
  source          = "../../../modules/region/rando"
  geography_group = "US"
  quantity        = 2
}

output "result" {
  value = module.region.result
}