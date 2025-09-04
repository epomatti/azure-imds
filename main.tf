terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
  }
}

locals {
  workload = "imds"
}

resource "azurerm_resource_group" "default" {
  name     = "rg-${local.workload}"
  location = var.location
}

module "vnet" {
  source              = "./modules/vnet"
  workload            = local.workload
  resource_group_name = azurerm_resource_group.default.name
  location            = azurerm_resource_group.default.location
}

module "vm" {
  source              = "./modules/vm"
  workload            = local.workload
  resource_group_name = azurerm_resource_group.default.name
  location            = azurerm_resource_group.default.location
  subnet_id           = module.vnet.subnet_id
  size                = var.vm_size
  vtpm_enabled        = var.vm_vtpm_enabled
  secure_boot_enabled = var.vm_secure_boot_enabled
  public_key_path     = var.vm_public_key_path
  image_publisher     = var.vm_image_publisher
  image_offer         = var.vm_image_offer
  image_sku           = var.vm_image_sku
  image_version       = var.vm_image_version
}

module "storage" {
  source              = "./modules/storage"
  workload            = local.workload
  resource_group_name = azurerm_resource_group.default.name
  location            = azurerm_resource_group.default.location

  vm_principal_id = module.vm.principal_id
}

module "acr" {
  source              = "./modules/acr"
  workload            = local.workload
  resource_group_name = azurerm_resource_group.default.name
  location            = azurerm_resource_group.default.location
  vm_principal_id     = module.vm.principal_id
}
