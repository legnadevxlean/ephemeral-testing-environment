# Variables for Ephemeral QA Environment

variable "resource_group_name" {
  description = "Name of the existing resource group to deploy into"
  type        = string
  default     = "leanangel"
}

variable "location" {
  description = "Azure region for resources"
  type        = string
  default     = "westeurope"
}

variable "environment" {
  description = "Environment name (dev, qa)"
  type        = string
  default     = "qa"

  validation {
    condition     = contains(["dev", "qa"], var.environment)
    error_message = "Environment must be one of: dev, qa"
  }
}

variable "run_id" {
  description = "Unique identifier for this run (GitHub run ID or timestamp)"
  type        = string

  validation {
    condition     = length(var.run_id) > 0
    error_message = "run_id cannot be empty"
  }
}

variable "container_image" {
  description = "Docker image to deploy (ACR or Docker Hub)"
  type        = string
  default     = "nginx:alpine" # Placeholder, will be overridden

  # Examples:
  # - Docker Hub: "myuser/myapp:latest"
  # - ACR: "myregistry.azurecr.io/myapp:v1"
}

# Azure Container Registry (ACR) Credentials - Optional

variable "acr_login_server" {
  description = "ACR login server (e.g., myregistry.azurecr.io)"
  type        = string
  default     = ""
}

variable "acr_username" {
  description = "ACR username"
  type        = string
  default     = ""
  sensitive   = true
}

variable "acr_password" {
  description = "ACR password"
  type        = string
  default     = ""
  sensitive   = true
}
