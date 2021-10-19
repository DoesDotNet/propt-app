resource "azurerm_resource_group" "app" {
  name     = format("propt-app-%s-ukso-rg", var.environment)
  location = "UK South"
}