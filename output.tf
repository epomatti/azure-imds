output "vm_public_ip" {
  value = module.vm.public_ip
}

output "primary_blob_endpoint" {
  value = module.storage.primary_blob_endpoint
}
