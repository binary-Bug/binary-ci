# terraform.tfvars

# location can be set here or passed from CI/CD
location = "Central India"

# resource_group_name and name_prefix are expected to be set from the CI/CD pipeline using -var flags or a generated tfvars file.
# Example GitHub Actions usage:
#   terraform apply -auto-approve -var "resource_group_name=${{ env.RESOURCE_GROUP_NAME }}" -var "name_prefix=${{ env.NAME_PREFIX }}"

# Name of the shared App Service Plan
app_service_plan_name = "app-service-plan"

# List of app services to deploy
app_services = [
	{
		name          = "api"
		plan          = "app-service-plan"
		sku           = "F1"
		current_stack = "dotnetcore"
		stack_version = "v8.0"
	},
	{
		name          = "ui"
		plan          = "app-service-plan"
		sku           = "F1"
		current_stack = "node"
		stack_version = "~20"
	}
]

sql_admin_username = "sqladminuser"
sql_admin_password = "SuperSecurePassword123!"
