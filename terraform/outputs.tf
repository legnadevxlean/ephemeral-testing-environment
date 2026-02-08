# Outputs - Values exposed after terraform apply

output "resource_group_name" {
  description = "Name of the created resource group"
  value       = azurerm_resource_group.qa.name
}

output "app_url" {
  description = "Public URL of the deployed application"
  value       = "http://${azurerm_container_group.app.fqdn}"
}

output "app_ip" {
  description = "Public IP address of the container"
  value       = azurerm_container_group.app.ip_address
}

output "container_name" {
  description = "Name of the container group"
  value       = azurerm_container_group.app.name
}

output "run_id" {
  description = "Run ID used for this deployment"
  value       = var.run_id
}
