output "vnet_link_names" {
  description = "Names of the virtual network links created"
  value       = [for v in azurerm_private_dns_zone_virtual_network_link.vnet_links : v.name]
}