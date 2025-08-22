terraform {
	required_providers {
		azurerm = {
			source  = "hashicorp/azurerm"
			version = ">= 3.0.0"
		}
	}
}

provider "azurerm" {
	features {}

	# Credentials (subscription_id, client_id, client_secret, tenant_id) will be automatically injected
	# by the GitHub Action using azure/login. No need to set them here for CI/CD.
}

provider "azapi" {}

# In CI/CD, set the following environment variables:
# ARM_SUBSCRIPTION_ID, ARM_CLIENT_ID, ARM_CLIENT_SECRET, ARM_TENANT_ID
# These can be set in your workflow using secrets or environment variables.
