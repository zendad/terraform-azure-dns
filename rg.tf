# dns resource group
resource "azurerm_resource_group" "dns_rg" {
  name     = "rg-dns-${local.name_prefix}"
  location = var.location
  tags     = var.default_tags
}