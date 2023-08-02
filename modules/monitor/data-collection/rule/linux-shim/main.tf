resource "azapi_resource" "main" {
  type                      = "Microsoft.Insights/dataCollectionRules@2021-04-01"
  name                      = var.name
  parent_id                 = var.resource_group_id
  location                  = var.location
  schema_validation_enabled = false

  body = jsonencode({
    properties = {
      description = "Data collection rule for VM Insights."
      dataSources = {
        performanceCounters = [
          {
            name = "VMInsightsPerfCounters",
            streams = [
              "Microsoft-InsightsMetrics"
            ],
            scheduledTransferPeriod    = "PT1M",
            samplingFrequencyInSeconds = 60,
            counterSpecifiers = [
              "\\VmInsights\\DetailedMetrics"
            ]
          }
        ]
        extensions = [
          {
            streams = [
              "Microsoft-ServiceMap"
            ],
            extensionName     = "DependencyAgent",
            extensionSettings = {},
            name              = "DependencyAgentDataSource"
          }
        ]
      }
      destinations = {
        logAnalytics = [
          {
            "workspaceResourceId" = var.log_analytics_workspace_id,
            "name"                = "VMInsightsPerf-Logs-Dest"
          }
        ]
      }
      dataFlows = [
        {
          streams = [
            "Microsoft-InsightsMetrics"
          ],
          destinations = [
            "VMInsightsPerf-Logs-Dest"
          ]
        },
        {
          streams = [
            "Microsoft-ServiceMap"
          ],
          destinations = [
            "VMInsightsPerf-Logs-Dest"
          ]
        }
      ]
    }
  })
}