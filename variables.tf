variable "location" {
  type = string
}

variable "subscription_id" {
  type = string
}

variable "vm_size" {
  type = string
}

variable "vm_vtpm_enabled" {
  type = bool
}

variable "vm_secure_boot_enabled" {
  type = bool
}

variable "vm_public_key_path" {
  type = string
}

variable "vm_image_publisher" {
  type = string
}

variable "vm_image_offer" {
  type = string
}

variable "vm_image_sku" {
  type = string
}

variable "vm_image_version" {
  type = string
}
