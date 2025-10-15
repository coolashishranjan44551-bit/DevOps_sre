
# DevOps‑SRE — Terraform + GitHub Actions starter

This repository is a minimal, cloud‑agnostic starter for running Terraform via GitHub Actions.
It includes AWS and Azure examples, a lightweight Python runner, and a few sanity tests.

## Layout
```
.github/workflows/terraform-automation.yml   # CI pipeline with matrix for cloud/env
aws/terraform/*                               # AWS example (S3 + tags)
azure/terraform/*                             # Azure example (Resource Group)
config/environments/dev/*.yml                 # Environment inputs (dev)
scripts/terraform_runner.py                   # Tiny Terraform CLI wrapper
scripts/package_project.py                    # Example packager for artifacts
tests/*                                       # Pytests
```

## Quick start (local)
```bash
# AWS
cd aws/terraform
terraform init
terraform validate
terraform plan -var-file='../../config/environments/dev/aws.yml'

# Azure
cd azure/terraform
terraform init
terraform validate
terraform plan -var-file='../../config/environments/dev/azure.yml'
```

## GitHub Actions
- Triggers on `push`/`pull_request` and supports `plan` on PRs and `apply` on main.
- Provide the secrets in your repository:
  - For AWS: `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`, `AWS_REGION`
  - For Azure: `ARM_CLIENT_ID`, `ARM_CLIENT_SECRET`, `ARM_SUBSCRIPTION_ID`, `ARM_TENANT_ID`

> This project is intentionally small and extensible — add modules, backends, policies, etc.
