# binary-devops

binary-devops is my personal GitHub Actions + Terraform repository that ties together CI, CD, and Azure infrastructure provisioning in one place. I use it to build, deploy, and manage cloud resources consistently across my projects.

---

## Why I Created This

I wanted a single source of truth for:
- Building and packaging UI, API, and database components  
- Publishing versioned artifacts to registries (npm, Docker, ACR, etc.)  
- Deploying to Azure App Service, Functions, or AKS  
- Provisioning and managing Azure resources declaratively with Terraform  

---

## Key Features

- Build and package components into versioned artifacts  
- Publish artifacts to npm, NuGet, Docker Registry, Azure Container Registry  
- Deploy workloads to Azure App Service, Functions, and AKS via reusable workflows  
- Define Terraform modules for resource groups, VNets, storage accounts, Key Vaults, AKS clusters, and more  
- Create composite GitHub Actions and Terraform modules to keep everything DRY  
- Parameterize workflows and modules to target multiple environments and subscriptions  

---

## Benefits

- End-to-end automation tailored to my personal projects  
- Consistent CI/CD and infrastructure patterns across all my repos  
- Rapid onboarding of new prototypes by importing predefined workflows and modules  
- Centralized visibility into build artifacts, deployments, and infra changes  
