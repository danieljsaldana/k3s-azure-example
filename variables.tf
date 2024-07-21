variable "resource_group_name" {
  description = "El nombre del grupo de recursos."
  type        = string
}

variable "location" {
  description = "La ubicación donde se crearán los recursos."
  type        = string
}

variable "vnet_name" {
  description = "El nombre de la red virtual."
  type        = string
}

variable "vnet_address_space" {
  description = "El espacio de direcciones de la red virtual."
  type        = list(string)
}

variable "subnet_name" {
  description = "El nombre de la subred."
  type        = string
}

variable "subnet_address_prefix" {
  description = "El prefijo de direcciones de la subred."
  type        = list(string)
}

variable "nsg_name" {
  description = "El nombre del grupo de seguridad de red (NSG)."
  type        = string
}

variable "vm_name" {
  description = "El nombre de la máquina virtual."
  type        = string
}

variable "vm_size" {
  description = "El tamaño de la máquina virtual."
  type        = string
}

variable "admin_username" {
  description = "El nombre de usuario administrador para la máquina virtual."
  type        = string
}

variable "ssh_public_key" {
  description = "La clave pública SSH."
  type        = string
}

variable "k3s_install_command" {
  description = "El comando para instalar k3s."
  type        = string
}
