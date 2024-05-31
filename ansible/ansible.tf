resource "ansible_playbook" "web" {
  playbook   = "playbook.yaml"
  name       = azurerm_public_ip.ansible.ip_address
  extra_vars = {
    ansible_user                 = "azureuser"
    ansible_ssh_private_key_file = "~/.ssh/id_rsa"
  }
}

output "ansible_stdout" {
  value = ansible_playbook.web.ansible_playbook_stdout
}
