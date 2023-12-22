data "azuread_client_config" "current" {}

resource "azurerm_storage_account" "default" {
  name                          = "st${var.workload}cxv891xsdf1d"
  resource_group_name           = var.resource_group_name
  location                      = var.location
  account_tier                  = "Standard"
  account_replication_type      = "LRS"
  account_kind                  = "StorageV2"
  enable_https_traffic_only     = true
  min_tls_version               = "TLS1_2"
  public_network_access_enabled = true
}

resource "azurerm_storage_container" "content" {
  name                  = "content"
  storage_account_name  = azurerm_storage_account.default.name
  container_access_type = "private"
}

resource "azurerm_storage_blob" "txt" {
  name                   = "test.txt"
  storage_account_name   = azurerm_storage_account.default.name
  storage_container_name = azurerm_storage_container.content.name
  type                   = "Block"
  source                 = "${path.module}/test.txt"
}

resource "azurerm_role_assignment" "default" {
  scope                = azurerm_storage_account.default.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = var.vm_principal_id
}
