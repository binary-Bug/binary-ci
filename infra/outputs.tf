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

# Output the names of all App Services
output "app_service_names" {
	description = "Names of all App Services"
	value       = [for app in azurerm_windows_web_app.apps : app.name]
}

# Output the default hostnames (URLs) for all App Services
output "app_service_urls" {
	description = "Default hostnames (URLs) for all App Services"
	value       = [for app in azurerm_windows_web_app.apps : app.default_hostname]
}

# Output the resource IDs of all App Services
output "app_service_ids" {
	description = "Resource IDs of all App Services"
	value       = [for app in azurerm_windows_web_app.apps : app.id]
}

output "sql_server_name" {
  description = "Name of the Azure SQL Server"
  value       = azurerm_mssql_server.main.name
}

output "sql_server_fqdn" {
  description = "Fully qualified domain name (FQDN) of the SQL Server"
  value       = azurerm_mssql_server.main.fully_qualified_domain_name
}

output "sql_database_name" {
  description = "Name of the Azure SQL Database"
  value       = azurerm_mssql_database.main.name
}

output "sql_admin_username" {
  description = "SQL Server administrator username"
  value       = azurerm_mssql_server.main.administrator_login
  sensitive   = false
}

output "sql_firewall_rule_name" {
  description = "Name of the firewall rule applied to the SQL Server"
  value       = azurerm_mssql_firewall_rule.allow_all.name
}
