# binary-ci
binary-ci is a centralized GitHub Actions repository dedicated to building artifacts and triggering downstream deployment pipelines. It abstracts and standardizes your build logic into reusable workflows, then invokes the appropriate deployment actions for any target environment.

Key Features
Build and package UI, API, and database components into versioned artifacts

Publish artifacts to registries or storage (npm, NuGet, Docker Registry, S3, etc.)

Trigger downstream deployment workflows in Azure, AWS, GCP, or custom environments

Define reusable composite actions and jobs to keep pipelines DRY

Benefits
Consistency: enforce a single, uniform build process across all repositories

Reusability: share build steps centrally instead of duplicating pipeline code

Agility: onboard new projects quickly by importing predefined build workflows

Visibility: track artifact creation and deployment triggers from one source of truth

Integrate binary-ci to streamline your artifact lifecycle and ensure every deployment pipeline invokes a trusted, versioned build process.
