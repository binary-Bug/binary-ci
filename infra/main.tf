# Create the resource group
resource "azurerm_resource_group" "main" {
	name     = var.resource_group_name
	location = var.location

	tags = {
		created_by = "terraform"
	}
}

# Create a shared App Service Plan for all app services
resource "azurerm_service_plan" "main" {
	name                = "${var.name_prefix}-${var.app_service_plan_name}"
	location            = azurerm_resource_group.main.location
	resource_group_name = azurerm_resource_group.main.name
	os_type             = "Windows"
	sku_name            = "F1"

	tags = {
		created_by = "terraform"
	}
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
      always_on = false
		}

		tags = {
			created_by = "terraform"
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

  tags = {
    created_by = "terraform"
  }
}

resource "azurerm_mssql_firewall_rule" "allow_all" {
  name                = "AllowAll"
  server_id           = azurerm_mssql_server.main.id
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "255.255.255.255"
}

resource "azapi_resource" "sql_database" {
  type      = "Microsoft.Sql/servers/databases@2024-11-01-preview"
  name      = "${var.name_prefix}-db"
  location  = azurerm_resource_group.main.location
  parent_id = azurerm_mssql_server.main.id

  tags = {
    created_by = "terraform"
  }

  body = jsonencode({
    sku = {
      name     = "GP_S_Gen5"
      tier     = "GeneralPurpose"
      family   = "Gen5"
      capacity = 2
    }

    properties = {
      collation                        = "SQL_Latin1_General_CP1_CI_AS"
      maxSizeBytes                     = 34359738368                     # 32 GB
      zoneRedundant                    = false
      minCapacity                      = 0.5
      autoPauseDelay                   = 60
      requestedBackupStorageRedundancy = "Local"
      useFreeLimit                     = true
      freeLimitExhaustionBehavior      = "AutoPause"
      readScale                        = "Disabled"
      createMode                       = "Default"
      isLedgerOn                       = false

      shortTermRetentionPolicy = {
        retentionDays = 7
      }
    }
  })

  schema_validation_enabled = false
  response_export_values    = ["*"]
}
