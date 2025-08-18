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
  description = "List of app services to deploy (name, plan, sku, runtime)"
  type = list(object({
    name     = string
    plan     = string
    sku      = string
    runtime  = string # Windows runtime stack, e.g., "DOTNETCORE|6.0", "NODE|18-lts"
  }))
  default = []
}
