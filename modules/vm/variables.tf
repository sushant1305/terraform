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

# Define uaerdata script
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
  default = "/root/modules/vm/key.pub"
}

variable "instance_type" {
  type  = string
  default = "Standard_DS1_v2" 
}
