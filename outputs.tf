output "public_dns_zones" {
  description = "Map of public DNS zones created"
  value = {
    for k, v in azurerm_dns_zone.public :
    k => {
      id   = v.id
      name = v.name
    }
  }
}

output "private_dns_zones" {
  description = "Map of private DNS zones created"
  value = {
    for k, v in azurerm_private_dns_zone.private :
    k => {
      id   = v.id
      name = v.name
    }
  }
}

output "vnet_links" {
  description = "Map of private DNS zone virtual network links"
  value = {
    for k, v in azurerm_private_dns_zone_virtual_network_link.vnet_links :
    k => v.id
  }
}
