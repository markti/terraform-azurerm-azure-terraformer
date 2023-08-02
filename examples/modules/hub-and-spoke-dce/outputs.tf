output "data_collection_endpoints" {
  value = {
    for k, v in module.collection_endpoint : k =>
    {
      id = v.id
    }
  }
}