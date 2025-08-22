# Output the resource group name
output "new_resource_group_name" {
	description = "The name of the resource group"
	value       = azurerm_resource_group.main.name
}

# Output the App Service Plan name
output "app_service_plan_name" {
	description = "The name of the App Service Plan"
	value       = azurerm_service_plan.main.name
}

output "app_services" {
  description = "Combined details of all App Services"
  value = [
    for app in azurerm_windows_web_app.apps : {
      name     = app.name
      url      = app.default_hostname
      id       = app.id
    }
  ]
}

output "sql_server_details" {
  description = "Combined details of the Azure SQL Server"
  value = {
    name     = azurerm_mssql_server.main.name
    fqdn     = azurerm_mssql_server.main.fully_qualified_domain_name
    username = azurerm_mssql_server.main.administrator_login
  }
  sensitive = false
}

output "sql_firewall_rule_name" {
  description = "Name of the firewall rule applied to the SQL Server"
  value       = azurerm_mssql_firewall_rule.allow_all.name
}

# output "sql_database_name" {
#   description = "Name of the Azure SQL Database"
#   value       = azurerm_mssql_database.main.name
# }

output "sql_database_details" {
  description = "Consolidated details of the Azure SQL Database created via azapi"
  value = {
    id                           = azapi_resource.sql_database.output["id"]
    name                         = azapi_resource.sql_database.output["name"]
    location                     = azapi_resource.sql_database.output["location"]
    sku_name                     = azapi_resource.sql_database.output["sku"]["name"]
    free_limit_enabled           = azapi_resource.sql_database.output["properties"]["useFreeLimit"]
    free_limit_behavior          = azapi_resource.sql_database.output["properties"]["freeLimitExhaustionBehavior"]
    max_size_gb                  = azapi_resource.sql_database.output["properties"]["maxSizeBytes"] / 1073741824
    collation                    = azapi_resource.sql_database.output["properties"]["collation"]
    auto_pause_delay_minutes     = azapi_resource.sql_database.output["properties"]["autoPauseDelay"]
    min_capacity                 = azapi_resource.sql_database.output["properties"]["minCapacity"]
    backup_storage_redundancy   = azapi_resource.sql_database.output["properties"]["requestedBackupStorageRedundancy"]
    zone_redundant               = azapi_resource.sql_database.output["properties"]["zoneRedundant"]
    short_term_retention_days   = azapi_resource.sql_database.output["properties"]["shortTermRetentionPolicy"]["retentionDays"]
  }
}
