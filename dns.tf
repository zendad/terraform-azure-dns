# dns resource group
resource "azurerm_resource_group" "dns_rg" {
  name     = "rg-dns-${local.name_prefix}"
  location = var.location
  tags     = var.default_tags
}

# create DNS Zones
# public
resource "azurerm_dns_zone" "public" {
  for_each = {
    for zone in var.dns_zones : zone.name => zone
    if zone.type == "public"
  }

  name                = each.value.name
  resource_group_name = azurerm_resource_group.dns_rg.name
  tags                = var.default_tags
}

# private
resource "azurerm_private_dns_zone" "private" {
  for_each = {
    for zone in var.dns_zones : zone.name => zone
    if zone.type == "private"
  }

  name                = each.value.name
  resource_group_name = azurerm_resource_group.dns_rg.name
  tags                = var.default_tags
}

# dns records
# A Records
resource "azurerm_dns_a_record" "public_a" {
  for_each = { for r in var.public_a_records : r.name => r }

  name                = each.value.name
  zone_name           = each.value.zone
  resource_group_name = azurerm_resource_group.dns_rg.name
  ttl                 = each.value.ttl
  records             = [each.value.ip]
}

resource "azurerm_private_dns_a_record" "private_a" {
  for_each = { for r in var.private_a_records : r.name => r }

  name                = each.value.name
  zone_name           = each.value.zone
  resource_group_name = azurerm_resource_group.dns_rg.name
  ttl                 = each.value.ttl
  records             = [each.value.ip]
}

# CNAME Records
resource "azurerm_dns_cname_record" "public_cname" {
  for_each = { for r in var.public_cname_records : r.name => r }

  name                = each.value.name
  zone_name           = each.value.zone
  resource_group_name = azurerm_resource_group.dns_rg.name
  ttl                 = each.value.ttl
  record              = each.value.target
}

resource "azurerm_private_dns_cname_record" "private_cname" {
  for_each = { for r in var.private_cname_records : r.name => r }

  name                = each.value.name
  zone_name           = each.value.zone
  resource_group_name = azurerm_resource_group.dns_rg.name
  ttl                 = each.value.ttl
  record              = each.value.target
}

# TXT Records
resource "azurerm_dns_txt_record" "public_txt" {
  for_each = { for r in var.public_txt_records : r.name => r }

  name                = each.value.name
  zone_name           = each.value.zone
  resource_group_name = azurerm_resource_group.dns_rg.name
  ttl                 = each.value.ttl

  dynamic "record" {
    for_each = each.value.values
    content {
      value = record.value
    }
  }
}

resource "azurerm_private_dns_txt_record" "private_txt" {
  for_each = { for r in var.private_txt_records : r.name => r }

  name                = each.value.name
  zone_name           = each.value.zone
  resource_group_name = azurerm_resource_group.dns_rg.name
  ttl                 = each.value.ttl

  dynamic "record" {
    for_each = each.value.values
    content {
      value = record.value
    }
  }
}

# MX Records
resource "azurerm_dns_mx_record" "public_mx" {
  for_each = { for r in var.public_mx_records : r.name => r }

  name                = each.value.name
  zone_name           = each.value.zone
  resource_group_name = azurerm_resource_group.dns_rg.name
  ttl                 = each.value.ttl

  dynamic "record" {
    for_each = range(length(each.value.prefs))
    content {
      preference = each.value.prefs[record.key]
      exchange   = each.value.hosts[record.key]
    }
  }
}

resource "azurerm_private_dns_mx_record" "private_mx" {
  for_each = { for r in var.private_mx_records : r.name => r }

  name                = each.value.name
  zone_name           = each.value.zone
  resource_group_name = azurerm_resource_group.dns_rg.name
  ttl                 = each.value.ttl

  dynamic "record" {
    for_each = range(length(each.value.prefs))
    content {
      preference = each.value.prefs[record.key]
      exchange   = each.value.hosts[record.key]
    }
  }
}

# VNet private link
resource "azurerm_private_dns_zone_virtual_network_link" "vnet_links" {
  for_each = { for v in var.vnet_links : v.name => v }

  name                  = each.value.name
  resource_group_name   = azurerm_resource_group.dns_rg.name
  private_dns_zone_name = each.value.zone
  virtual_network_id    = each.value.vnet_id
  tags                  = var.default_tags
}