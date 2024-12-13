resource "azurerm_storage_account" "storage" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags                     = var.tags
}

resource "azurerm_storage_container" "container" {
  for_each = {
    source      = var.source_folder_name,
    destination = var.destination_folder_name
  }

  name                  = each.key
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = var.container_access_type
}

resource "azurerm_storage_blob" "test_file" {
  name                   = "test.txt"
  storage_account_name   = azurerm_storage_account.storage.name
  storage_container_name = azurerm_storage_container.container["source"].name
  type                   = "Block"
  source_content         = "Hello World"
}

output "storage_account_name" {
  value = azurerm_storage_account.storage.name
}

output "storage_account_key" {
  value = azurerm_storage_account.storage.primary_access_key
}
