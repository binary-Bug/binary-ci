# backend.tf
# Local backend for Terraform state
terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}
