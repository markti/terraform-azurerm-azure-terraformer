/*
output "workspace_id" {
  value = module.log_analytics_workspace.workspace_id
}
*/
output "endpoints" {
  value = module.hub_spoke_monitor.data_collection_endpoints
}