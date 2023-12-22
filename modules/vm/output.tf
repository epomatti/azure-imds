output "public_ip" {
  value = azurerm_public_ip.default.ip_address
}

output "vm_id" {
  value = azurerm_linux_virtual_machine.default.id
}

output "principal_id" {
  value = azurerm_linux_virtual_machine.default.identity[0].principal_id
}
