# Output the resource group name
output "resource_group_name" {
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
	value       = [for app in azurerm_windows_web_app.apps : app.default_site_hostname]
}

# Output the resource IDs of all App Services
output "app_service_ids" {
	description = "Resource IDs of all App Services"
	value       = [for app in azurerm_windows_web_app.apps : app.id]
}
