locals {
  roles = [
    "AcrPull", "AcrPush", "AcrDelete"
  ]
}

resource "azurerm_container_registry" "default" {
  name                          = "acr${var.workload}"
  location                      = var.location
  resource_group_name           = var.resource_group_name
  sku                           = "Basic"
  admin_enabled                 = false
  public_network_access_enabled = true
}

resource "azurerm_role_assignment" "virtual_machine_acr" {
  for_each = toset(local.roles)
  # name                 = uuid()
  scope                = azurerm_container_registry.default.id
  role_definition_name = each.key
  principal_id         = var.vm_principal_id
}
