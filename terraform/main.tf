# Infrastructure for Ephemeral QA Environments
# Provisions Azure Container Instances for valid E2E testing

terraform {
  required_version = ">= 1.0.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}

  # Disable auto-registration of Resource Providers.
  # Required when the Service Principal lacks Microsoft.*/register/action permissions.
  # Ensure the providers you need are already registered in the subscription:
  #   az provider register --namespace Microsoft.ContainerInstance
  #   az provider register --namespace Microsoft.Resources
  skip_provider_registration = true
}

locals {
  # Standardized naming convention
  resource_name_prefix = "qa-app-${var.run_id}"
  
  # Centralized tagging strategy
  common_tags = {
    environment = var.environment
    run_id      = var.run_id
    managed_by  = "terraform"
    project     = "ephemeral-testing"
  }
}

# Use existing resource group (sp-tests has Contributor scoped to this RG)
data "azurerm_resource_group" "qa" {
  name = var.resource_group_name
}

resource "azurerm_container_group" "app" {
  name                = "aci-${local.resource_name_prefix}"
  location            = data.azurerm_resource_group.qa.location
  resource_group_name = data.azurerm_resource_group.qa.name
  os_type             = "Linux"
  ip_address_type     = "Public"
  dns_name_label      = local.resource_name_prefix

  dynamic "image_registry_credential" {
    for_each = var.acr_login_server != "" ? [1] : []
    content {
      server   = var.acr_login_server
      username = var.acr_username
      password = var.acr_password
    }
  }

  container {
    name   = "web-app"
    image  = var.container_image
    cpu    = "0.5"
    memory = "0.5"

    ports {
      port     = 80
      protocol = "TCP"
    }

    environment_variables = {
      APP_ENV = var.environment
      RUN_ID  = var.run_id
    }
  }

  tags = local.common_tags
}
