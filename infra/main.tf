# Create the resource group
resource "azurerm_resource_group" "main" {
	name     = var.resource_group_name
	location = var.location
}

# Create a shared App Service Plan for all app services
resource "azurerm_service_plan" "main" {
	name                = "${var.name_prefix}-${var.app_service_plan_name}"
	location            = azurerm_resource_group.main.location
	resource_group_name = azurerm_resource_group.main.name
	kind                = "Windows"
	reserved            = false
	os_type             = "Windows"
	sku_name            = "F1"
}

# Create multiple App Services using the app_services variable
resource "azurerm_app_service" "apps" {
	for_each            = { for app in var.app_services : app.name => app }
	name                = "${var.name_prefix}-${each.value.name}"
	location            = azurerm_resource_group.main.location
	resource_group_name = azurerm_resource_group.main.name
	app_service_plan_id = azurerm_service_plan.main.id

	site_config {
		windows_fx_version = each.value.runtime
	}
	# Add more configuration as needed (e.g., app_settings)
}
