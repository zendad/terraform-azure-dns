# private dns zone
resource "azurerm_private_dns_zone" "private_dns_zone" {
  name                = "${var.environment}.zensaas.vaultcore.azure.net"
  resource_group_name = azurerm_resource_group.dns_rg.name
  tags                = var.default_tags
}

# Public DNS Zone
resource "azurerm_dns_zone" "public_dns_zone" {
  name                = "${var.environment}.zensaas.vaultcore.azure.net"
  resource_group_name = azurerm_resource_group.dns_rg.name
  tags                = var.default_tags
}

# vnet private link
resource "azurerm_private_dns_zone_virtual_network_link" "dns_link" {
  name                  = "dns-link-${local.name_prefix}"
  resource_group_name   = azurerm_resource_group.dns_rg.name
  private_dns_zone_name = azurerm_private_dns_zone.private_dns_zone.name
  virtual_network_id    = data.terraform_remote_state.aks_cluster.cluster_vnet_id
  tags                  = var.default_tags
}
