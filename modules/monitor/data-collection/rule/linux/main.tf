resource "random_string" "name" {
  length  = 8
  special = false
  upper   = false
}

locals {
  azure_monitor_destination = "azureMonitorMetrics-default"

  azure_monitor_metrics_stream     = "Microsoft-InsightsMetrics"
  azure_monitor_perf_stream        = "Microsoft-Perf"
  azure_monitor_syslog_stream      = "Microsoft-Syslog"
  azure_monitor_service_map_stream = "Microsoft-ServiceMap"

  log_analytics_destination = "log-${random_string.name.result}"
}

resource "azurerm_monitor_data_collection_rule" "main" {
  name                = "dcr-${var.name}"
  resource_group_name = var.resource_group_name
  location            = var.location

  data_sources {

    performance_counter {
      name                          = "VMInsightsPerfCounters"
      streams                       = [local.azure_monitor_metrics_stream]
      sampling_frequency_in_seconds = 60
      counter_specifiers            = ["\\VmInsights\\DetailedMetrics"]
    }

    extension {
      streams        = [local.azure_monitor_service_map_stream]
      extension_name = "DependencyAgent"
      name           = "DependencyAgentDataSource"
    }

  }

  destinations {
    log_analytics {
      name                  = local.log_analytics_destination
      workspace_resource_id = var.log_analytics_workspace_id
    }
  }

  data_flow {
    streams      = [local.azure_monitor_metrics_stream]
    destinations = [local.log_analytics_destination]
  }

  data_flow {
    streams      = [local.azure_monitor_service_map_stream]
    destinations = [local.log_analytics_destination]
  }

}
