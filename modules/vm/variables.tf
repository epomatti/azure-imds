variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "workload" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "size" {
  type = string
}

variable "vtpm_enabled" {
  type = bool
}

variable "secure_boot_enabled" {
  type = bool
}

variable "public_key_path" {
  type = string
}

variable "image_publisher" {
  type = string
}

variable "image_offer" {
  type = string
}

variable "image_sku" {
  type = string
}

variable "image_version" {
  type = string
}
