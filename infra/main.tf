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
	os_type             = "Windows"
	sku_name            = "F1"
}

# Create multiple App Services using the app_services variable
resource "azurerm_windows_web_app" "apps" {
		for_each            = { for app in var.app_services : app.name => app }
		name                = "${var.name_prefix}-${each.value.name}"
		location            = azurerm_resource_group.main.location
		resource_group_name = azurerm_resource_group.main.name
		service_plan_id     = azurerm_service_plan.main.id

		site_config {
			application_stack {
				current_stack      = each.value.current_stack
				dotnet_version     = each.value.current_stack == "dotnetcore" ? each.value.stack_version : null
				node_version       = each.value.current_stack == "node"       ? each.value.stack_version : null
			}
		}
}

resource "azurerm_mssql_server" "main" {
  name                         = "${var.name_prefix}"
  location                     = azurerm_resource_group.main.location
  resource_group_name          = azurerm_resource_group.main.name
  version                      = "12.0"  # default version
  administrator_login          = var.sql_admin_username
  administrator_login_password = var.sql_admin_password

  minimum_tls_version = "1.2"
}

resource "azurerm_mssql_database" "main" {
  name                = "${var.name_prefix}-db"
  server_id           = azurerm_mssql_server.main.id
  collation           = "SQL_Latin1_General_CP1_CI_AS"
  max_size_gb         = 32
  zone_redundant      = false

  sku_name            = "GP_S_Gen5_2"  # General Purpose, Serverless, Gen5, 2 vCores
  min_capacity        = 0.5            # Optional: lower bound for serverless scaling
  auto_pause_delay_in_minutes = 60     # Optional: auto-pause after inactivity

  storage_account_type = "Local"       # Locally-redundant backup storage

  # PITR retention
  short_term_retention_policy {
    retention_days = 7
  }

  # Public access enabled by default; firewall rules can be added separately
}

resource "azurerm_mssql_firewall_rule" "allow_all" {
  name                = "AllowAll"
  server_id           = azurerm_mssql_server.main.id
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "255.255.255.255"
}
