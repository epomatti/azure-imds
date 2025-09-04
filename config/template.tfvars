# General
location        = "eastus2"
subscription_id = "00000000-0000-0000-0000-000000000000"

# Virtual Machine
# https://documentation.ubuntu.com/azure/azure-how-to/instances/find-ubuntu-images/
vm_size                = "Standard_B2s_v2"
vm_vtpm_enabled        = true
vm_secure_boot_enabled = true
vm_public_key_path     = ".keys/azure.pub"
vm_image_publisher     = "Canonical"
vm_image_offer         = "0001-com-ubuntu-server-jammy"
vm_image_sku           = "22_04-lts-gen2"
vm_image_version       = "latest"
