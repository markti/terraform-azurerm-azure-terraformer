resource "random_string" "name" {
  length  = 8
  special = false
  upper   = false
}

locals {
  azure_monitor_destination = "azureMonitorMetrics-default"

  azure_monitor_metrics_stream = "Microsoft-InsightsMetrics"
  azure_monitor_perf_stream    = "Microsoft-Perf"
  azure_monitor_syslog_stream  = "Microsoft-syslog"

  log_analytics_destination = "log-${random_string.name.result}"
}

resource "azurerm_monitor_data_collection_rule" "main" {
  name                        = "dcr-${var.name}"
  resource_group_name         = var.resource_group_name
  location                    = var.location
  data_collection_endpoint_id = var.data_collection_endpoint_id

  data_sources {

    performance_counter {
      name = "perf-counter-${random_string.name.result}"
      streams = [
        local.azure_monitor_perf_stream,
        local.azure_monitor_metrics_stream
      ]
      sampling_frequency_in_seconds = 60
      counter_specifiers = [
        "Processor(*)\\% Processor Time",
        "Processor(*)\\% Idle Time",
        "Processor(*)\\% User Time",
        "Processor(*)\\% Nice Time",
        "Processor(*)\\% Privileged Time",
        "Processor(*)\\% IO Wait Time",
        "Processor(*)\\% Interrupt Time",
        "Processor(*)\\% DPC Time",
        "Memory(*)\\Available MBytes Memory",
        "Memory(*)\\% Available Memory",
        "Memory(*)\\Used Memory MBytes",
        "Memory(*)\\% Used Memory",
        "Memory(*)\\Pages/sec",
        "Memory(*)\\Page Reads/sec",
        "Memory(*)\\Page Writes/sec",
        "Memory(*)\\Available MBytes Swap",
        "Memory(*)\\% Available Swap Space",
        "Memory(*)\\Used MBytes Swap Space",
        "Memory(*)\\% Used Swap Space",
        "Logical Disk(*)\\% Free Inodes",
        "Logical Disk(*)\\% Used Inodes",
        "Logical Disk(*)\\Free Megabytes",
        "Logical Disk(*)\\% Free Space",
        "Logical Disk(*)\\% Used Space",
        "Logical Disk(*)\\Logical Disk Bytes/sec",
        "Logical Disk(*)\\Disk Read Bytes/sec",
        "Logical Disk(*)\\Disk Write Bytes/sec",
        "Logical Disk(*)\\Disk Transfers/sec",
        "Logical Disk(*)\\Disk Reads/sec",
        "Logical Disk(*)\\Disk Writes/sec",
        "Network(*)\\Total Bytes Transmitted",
        "Network(*)\\Total Bytes Received",
        "Network(*)\\Total Bytes",
        "Network(*)\\Total Packets Transmitted",
        "Network(*)\\Total Packets Received",
        "Network(*)\\Total Rx Errors",
        "Network(*)\\Total Tx Errors",
        "Network(*)\\Total Collisions"
      ]
    }

    syslog {
      name    = "syslog-${random_string.name.result}"
      streams = [local.azure_monitor_syslog_stream]
      facility_names = [
        "auth",
        "authpriv",
        "cron",
        "daemon",
        "mark",
        "kern",
        "local0",
        "local1",
        "local2",
        "local3",
        "local4",
        "local5",
        "local6",
        "local7",
        "lpr",
        "mail",
        "news",
        "syslog",
        "user",
        "uucp"
      ]
      log_levels = [
        "Debug",
        "Info",
        "Notice",
        "Warning",
        "Error",
        "Critical",
        "Alert",
        "Emergency"
      ]
    }

  }

  destinations {
    log_analytics {
      name                  = local.log_analytics_destination
      workspace_resource_id = var.log_analytics_workspace_id
    }
    azure_monitor_metrics {
      name = local.azure_monitor_destination
    }

  }

  data_flow {
    streams       = [local.azure_monitor_metrics_stream]
    destinations  = local.azure_monitor_destination
    transform_kql = "source"
    output_stream = local.azure_monitor_metrics_stream
  }

  data_flow {
    streams       = [local.azure_monitor_perf_stream]
    destinations  = [local.log_analytics_destination]
    transform_kql = "source"
    output_stream = local.azure_monitor_perf_stream
  }

  data_flow {
    streams       = [local.azure_monitor_syslog_stream]
    destinations  = [local.log_analytics_destination]
    transform_kql = "source"
    output_stream = local.azure_monitor_syslog_stream
  }

}
