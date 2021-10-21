resource "azurerm_storage_account" "app" {
  name                     = format("%ssaukso", local.storage_name_prefix)
  resource_group_name      = azurerm_resource_group.app.name
  location                 = azurerm_resource_group.app.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  enable_https_traffic_only = true

  static_website {
    index_document     = "index.html"
    error_404_document = "404.html"
  }

  tags = local.common_tags
}