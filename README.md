# Ephemeral QA Infrastructure

This repository provides an automated system to provision, test, and deprovision cloud-based QA environments on-demand. It ensures that every test run starts with a clean slate, avoiding environmental drift and reducing infrastructure costs.

## Key Benefits

- **Cost Optimization**: Resources only exist during the execution of the test suite.
- **Environment Isolation**: Each execution creates a unique set of resources (Resource Group, URL, ACI). Multiple pipelines can run concurrently without conflicts.
- **Reliability**: Automated cleanup ensures no orphaned resources are left behind, with specialized verification steps using the Azure CLI.

## Tech Stack

- **Application**: React (Vite)
- **Infrastructure**: Terraform (IaC) on Azure Container Instances (ACI)
- **CI/CD**: GitHub Actions
- **Testing**: Python + Behave (BDD) + Selenium
- **Reporting**: Allure Report with history persistence via GitHub Pages

## Initial Setup

### 1. Azure Configuration
You will need an **Azure Container Registry (ACR)** to host application images and a **Service Principal** with `Contributor` permissions to allow GitHub Actions to manage resources.

### 2. GitHub Secrets
Configure the following secrets in your repository (`Settings > Secrets > Actions`):

| Secret Name | Description |
| :--- | :--- |
| `ARM_CLIENT_ID` / `ARM_CLIENT_SECRET` | Azure Service Principal credentials |
| `ARM_SUBSCRIPTION_ID` / `ARM_TENANT_ID` | Azure Account identifiers |
| `ACR_LOGIN_SERVER` | Your ACR Login URL (e.g., `myregistry.azurecr.io`) |
| `ACR_USERNAME` / `ACR_PASSWORD` | ACR authentication credentials |

## Workflow Overview

1. **01 - Run Ephemeral Tests**: The main CI/CD pipeline. Triggered on push to `main`/`qa` or Pull Requests. It executes the full lifecycle: Build -> Provision -> Test -> Report -> Destroy.
2. **02 - MANUAL - Deploy Environment**: Provisions a persistent environment for a specified duration (e.g., 30 minutes). Useful for manual exploratory testing or debugging.
3. **MANUAL - Run Tests against url**: Executes the automated test suite against a specified target URL (Local, Dev, or an existing ACI instance).

## Local Development & Testing

To run the system locally:

```bash
# 1. Start the application
cd app
npm install && npm run dev

# 2. Execute tests (requires Python 3.11+)
cd tests
pip install -r requirements.txt
$env:BASE_URL = "http://localhost:5173"  # Use your local Vite URL
behave
```

## Engineering Patterns

- **BDD (Behave)**: Tests use Gherkin syntax to ensure scenarios are readable for both technical and non-technical stakeholders.
- **Page Object Model (POM)**: UI interactions are encapsulated in `tests/pages/` to ensure the test suite is easy to maintain.
- **State Persistence**: The `terraform.tfstate` is stored as a GitHub artifact during the run. This is critical for the `cleanup` job to accurately identify and remove all provisioned resources, even if the test phase fails.
- **Infrastructure Verification**: After the `terraform destroy` command, the workflows perform a manual check via Azure CLI (`az group exists`) to guarantee the Resource Group has been fully removed.

## Reporting

Allure reports are automatically merged and published to the `gh-pages` branch. 
1. Enable GitHub Pages in **Settings > Pages**.
2. Set the Source to the `gh-pages` branch.
3. Access the latest results and execution history via the generated GitHub Pages URL.

---
*Professional blueprint for scalable, cost-effective ephemeral testing.*
