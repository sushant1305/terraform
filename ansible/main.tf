resource "azurerm_resource_group" "ansible" {
  name     = "ansible-resources"
  location = "East US"
}

resource "azurerm_virtual_network" "ansible" {
  name                 = "ansible-network"
  address_space        = ["10.0.0.0/16"]
  location             = azurerm_resource_group.ansible.location
  resource_group_name  = azurerm_resource_group.ansible.name
}

resource "azurerm_subnet" "ansible" {
  name                 = "ansible-subnet"
  resource_group_name  = azurerm_resource_group.ansible.name
  virtual_network_name = azurerm_virtual_network.ansible.name
  address_prefixes     = ["10.0.0.0/24"]
}

resource "azurerm_public_ip" "ansible" {
  name                 = "ansible-publicip"
  location             = azurerm_resource_group.ansible.location
  resource_group_name  = azurerm_resource_group.ansible.name
  allocation_method    = "Dynamic"
}

resource "azurerm_network_security_group" "ansible" {
  name                 = "ansible-nsg"
  location             = azurerm_resource_group.ansible.location
  resource_group_name  = azurerm_resource_group.ansible.name

  security_rule {
    name                        = "ssh"
    priority                    = 1000
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_range      = "22"
    source_address_prefix       = "*"
    destination_address_prefix  = "*"
  }

  security_rule {
    name                        = "http"
    priority                    = 1001
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_range      = "80"
    source_address_prefix       = "*"
    destination_address_prefix  = "*"
  }
}

resource "azurerm_network_interface" "ansible" {
  name                 = "ansible-nic"
  location             = azurerm_resource_group.ansible.location
  resource_group_name  = azurerm_resource_group.ansible.name

  ip_configuration {
    name                          = "ansible"
    subnet_id                     = azurerm_subnet.ansible.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.ansible.id
  }
}

resource "azurerm_network_interface_security_group_association" "ansible" {
  network_interface_id       = azurerm_network_interface.ansible.id
  network_security_group_id  = azurerm_network_security_group.ansible.id
}

resource "azurerm_linux_virtual_machine" "ansible" {
  name                  = "ansible-vm"
  location              = azurerm_resource_group.ansible.location
  resource_group_name   = azurerm_resource_group.ansible.name
  network_interface_ids = [azurerm_network_interface.ansible.id]
  size                  = "Standard_DS1_v2"

  os_disk {
    name                 = "myOsDisk"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  computer_name                   = "ansible-vm"
  admin_username                  = "azureuser"
  disable_password_authentication = true

  admin_ssh_key {
    username    =  "azureuser"
    public_key  =  file("~/.ssh/id_rsa.pub")
  }

  depends_on = [azurerm_network_interface_security_group_association.ansible]
}

output "public_ip_address" {
  value = azurerm_public_ip.ansible.ip_address
}
