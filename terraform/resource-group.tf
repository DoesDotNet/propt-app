resource "azurerm_resource_group" "app" {
  name     = format("%s-rg-ukso", local.name_prefix)
  location = "UK South"
}