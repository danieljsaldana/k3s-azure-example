output "vm_public_ip" {
  description = "La dirección IP pública de la máquina virtual."
  value       = azurerm_public_ip.public_ip.ip_address
}
