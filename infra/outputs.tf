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

locals {
  sql_db_output = jsondecode(azapi_resource.sql_database.output)
}

output "sql_database_details" {
  value = {
    id                         = local.sql_db_output.id
    name                       = local.sql_db_output.name
    location                   = local.sql_db_output.location
    sku_name                   = local.sql_db_output.sku.name
    free_limit_enabled         = local.sql_db_output.properties.useFreeLimit
    free_limit_behavior        = local.sql_db_output.properties.freeLimitExhaustionBehavior
    max_size_gb                = local.sql_db_output.properties.maxSizeBytes / 1073741824
    collation                  = local.sql_db_output.properties.collation
    auto_pause_delay_minutes   = local.sql_db_output.properties.autoPauseDelay
    min_capacity               = local.sql_db_output.properties.minCapacity
    backup_storage_redundancy = local.sql_db_output.properties.requestedBackupStorageRedundancy
    zone_redundant             = local.sql_db_output.properties.zoneRedundant
  }
}
