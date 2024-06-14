resource "azurerm_availability_set" "myavailabilityset" {
  name                = "example-aset"
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_public_ip" "my-public-ip" {
  name                = var.public_ip_address_name
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Dynamic"

  tags = {
    environment = "Testing"
  }
}

resource "azurerm_network_interface" "mynetworkinterface" {
  name                = var.network_interface_name
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.azurerm_subnet_id
    private_ip_address_allocation = "Dynamic"

    public_ip_address_id = azurerm_public_ip.my-public-ip.id 
  }
}

# Windows 10 Virtual Machine
resource "azurerm_windows_virtual_machine" "myvirtualmachine" {
  name                = var.my_virtual_machine_name
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = var.my_virtual_machine_size
  admin_username      = "adminuser"
  admin_password      = var.my_virtual_machine_password
  availability_set_id = azurerm_availability_set.myavailabilityset.id
  network_interface_ids = [
    azurerm_network_interface.mynetworkinterface.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsDesktop"
    offer     = var.source_image_offer
    sku       = var.source_image_sku
    version   = "latest"
  }
}

# Security Group for allowing RDP Connection
resource "azurerm_network_security_group" "sg-rdp-connection" {
  name                = "allowrdpconnection"
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "rdpport"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    environment = "Testing"
  }
}

# Associate security group with network interface
resource "azurerm_network_interface_security_group_association" "example" {
  network_interface_id      = azurerm_network_interface.mynetworkinterface.id
  network_security_group_id = azurerm_network_security_group.sg-rdp-connection.id
}