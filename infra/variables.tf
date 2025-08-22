# Prefix for all resource names (e.g., environment or project name)
variable "name_prefix" {
  description = "Prefix for all resource names (e.g., environment or project name)"
  type        = string
}
# Name of the shared App Service Plan
variable "app_service_plan_name" {
  description = "Name of the shared Azure App Service Plan"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the Azure Resource Group"
  type        = string
}

variable "location" {
  description = "Azure region to deploy resources"
  type        = string
}

# For multiple app services, define as a list of objects (optional, for future use)
variable "app_services" {
  description = "List of app services to deploy (name, plan, sku, current_stack, stack_version)"
  type = list(object({
    name          = string
    plan          = string
    sku           = string
    current_stack = string
    stack_version = string
  }))
  default = []
}

variable "sql_admin_username" {
  description = "Administrator username for the Azure SQL Server"
  type        = string
}

variable "sql_admin_password" {
  description = "Administrator password for the Azure SQL Server"
  type        = string
  sensitive   = true
}
