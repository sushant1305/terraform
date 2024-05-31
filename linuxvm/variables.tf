variable "resource_group_location" {
  type        = string
  default     = "East US"
  description = "Location of the resource group"
}

variable "resource_group_name_prefix" {
  type        = string
  default     = "rg"
  description = "Prefix of the resource group, that will be combained with random string"
}

variable "user_data_script" {
  type    = string
  default = <<-SCRIPT
#!/bin/bash
sudo apt update
sudo apt install nginx -y
SCRIPT
}

variable "ssh_public_key" {
  type    = string
  default = "key.pub"
}

variable "stop_vm" {
  type    = bool
  default = true
}
