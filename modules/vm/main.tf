resource "azurerm_windows_virtual_machine" "myvm" {
  name                  = "mytfvm"
  location              = var.resource_group_name
  resource_group_name   = var.resource_group_location
  network_interface_ids = [azurerm_network_interface.mynic.id]
  size               = "Standard_B2as_v2"
  admin_username        = var.admin_username
  admin_password        = var.admin_password

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Microsoftwindowsdesktop"
    offer     = "windows-11"
    sku       = "win11-23h2-pron"
    version   = "latest"
  }
} # End of the file

# Security Group - allowing RDP Connection
resource "azurerm_network_security_group" "sg-rdp-connection" {
  name                = "allowrdpconnection"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  security_rule {
    name                       = "rdpport"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    environment = "Testing"
  }
}

# Associate security group with network interface
resource "azurerm_network_interface_security_group_association" "example" {
  network_interface_id      = azurerm_network_interface.mynic.id
  network_security_group_id = azurerm_network_security_group.sg-rdp-connection.id
}

resource "azurerm_public_ip" "mypip" {
  name                = "mytfpip"
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  allocation_method   = "Static"
} # End of the file

resource "azurerm_network_interface" "mynic" {
  name                = "mytfnic"
  location            = var.resource_group_name
  resource_group_name = var.resource_group_location

  ip_configuration {
    name                          = "mytfipconfig"
    subnet_id                     = azurerm_subnet.web_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.mypip.id
  }
}