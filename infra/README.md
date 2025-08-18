# Terraform Azure Infrastructure

This folder contains Terraform configuration for Azure resources.

## Files
- `main.tf`: Main resource definitions
- `variables.tf`: Input variables
- `outputs.tf`: Outputs
- `providers/azure.tf`: Azure provider configuration (placeholder)
- `backend.tf`: Local backend configuration

## Usage
1. Add your Azure provider configuration in `providers/azure.tf`.
2. Run `terraform init` in this directory.
3. Run `terraform plan` and `terraform apply` to deploy resources.
