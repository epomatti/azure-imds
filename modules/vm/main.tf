resource "azurerm_public_ip" "default" {
  name                = "pip-${var.workload}"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "default" {
  name                = "nic-${var.workload}"
  resource_group_name = var.resource_group_name
  location            = var.location

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.default.id
  }

  lifecycle {
    create_before_destroy = true
  }
}

locals {
  username = "azureuser"
}

resource "azurerm_linux_virtual_machine" "default" {
  name                  = "vm-${var.workload}3"
  resource_group_name   = var.resource_group_name
  location              = var.location
  size                  = var.size
  admin_username        = local.username
  network_interface_ids = [azurerm_network_interface.default.id]

  vtpm_enabled        = var.vtpm_enabled
  secure_boot_enabled = var.secure_boot_enabled

  patch_mode                                             = "AutomaticByPlatform"
  bypass_platform_safety_checks_on_user_schedule_enabled = true

  custom_data = filebase64("${path.module}/cloud-init.sh")

  identity {
    type = "SystemAssigned"
  }

  admin_ssh_key {
    username   = local.username
    public_key = file(var.public_key_path)
  }

  os_disk {
    name                 = "osdisk-linux-${var.workload}"
    caching              = "ReadOnly"
    storage_account_type = "StandardSSD_LRS"
  }

  source_image_reference {
    publisher = var.image_publisher
    offer     = var.image_offer
    sku       = var.image_sku
    version   = var.image_version
  }
}
