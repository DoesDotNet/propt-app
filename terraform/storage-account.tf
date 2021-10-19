resource "azurerm_storage_account" "app" {
  name                     = format("propt-app-%s-ukso-sa", var.environment)
  resource_group_name      = azurerm_resource_group.app.name
  location                 = azurerm_resource_group.app.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = local.common_tags
}