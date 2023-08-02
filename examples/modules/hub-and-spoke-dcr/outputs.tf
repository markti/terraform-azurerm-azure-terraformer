output "data_collection_rules" {
  value = {
    for k, v in module.collection_rule : k =>
    {
      id = v.id
    }
  }
}