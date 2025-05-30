# Terraform Module - Azure DNS
This module manages Azure DNS zones (public and private) and supports various DNS record types including A, CNAME, TXT, and MX. It also supports linking private DNS zones to virtual networks.

# Attributes
- Create public and private DNS zones.
- Create A, CNAME, TXT, and MX records.
- Support for multiple zones and records.
- Virtual network links for private zones.
- Tags support for all resources.

# Usage
```hcl
module "dns" {
  source = "../"

  location    = "eastus"
  name_prefix = "dev"
  default_tags = {
    environment = "dev"
    project     = "vaultcore"
  }

  dns_zones = [
    { name = "dev.zensaas.vaultcore.azure.net", type = "public" },
    { name = "dev.zensaas.vaultcore.azure.net", type = "private" }
  ]

  public_a_records = {
    "api" = {
      name = "api"
      ip   = "1.2.3.4"
      ttl  = 300
      zone = "dev.zensaas.vaultcore.azure.net"
    }
  }

  private_a_records = {
    "internal-api" = {
      name = "internal-api"
      ip   = "10.0.0.4"
      ttl  = 300
      zone = "dev.zensaas.vaultcore.azure.net"
    }
  }

  public_cname_records  = {}
  private_cname_records = {}

  public_txt_records = {
    "spf" = {
      name   = "spf"
      ttl    = 3600
      zone   = "dev.zensaas.vaultcore.azure.net"
      values = ["v=spf1 include:spf.protection.outlook.com -all"]
    }
  }

  private_txt_records = {}

  public_mx_records = {
    "mail" = {
      name  = "mail"
      ttl   = 3600
      zone  = "dev.zensaas.vaultcore.azure.net"
      prefs = [10]
      hosts = ["mail.protection.outlook.com"]
    }
  }

  private_mx_records = {}

  vnet_links = {
    "vnet-link1" = {
      name    = "vnet-link1"
      vnet_id = "/subscriptions/xxxx/resourceGroups/rg-network/providers/Microsoft.Network/virtualNetworks/vnet-hub"
      zone    = "dev.zensaas.vaultcore.azure.net"
    }
  }
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.7.0 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | ~> 3.0.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.107.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.3.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 4.30.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_dns_a_record.public_a](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_a_record) | resource |
| [azurerm_dns_cname_record.public_cname](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_cname_record) | resource |
| [azurerm_dns_mx_record.public_mx](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_mx_record) | resource |
| [azurerm_dns_txt_record.public_txt](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_txt_record) | resource |
| [azurerm_dns_zone.public](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_zone) | resource |
| [azurerm_private_dns_a_record.private_a](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_a_record) | resource |
| [azurerm_private_dns_cname_record.private_cname](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_cname_record) | resource |
| [azurerm_private_dns_mx_record.private_mx](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_mx_record) | resource |
| [azurerm_private_dns_txt_record.private_txt](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_txt_record) | resource |
| [azurerm_private_dns_zone.private](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone_virtual_network_link.vnet_links](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_resource_group.dns_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_vnet_link"></a> [create\_vnet\_link](#input\_create\_vnet\_link) | Whether to create a private DNS zone virtual network link | `bool` | `false` | no |
| <a name="input_default_tags"></a> [default\_tags](#input\_default\_tags) | Default tags for all resources | `map(string)` | `{}` | no |
| <a name="input_dns_zones"></a> [dns\_zones](#input\_dns\_zones) | List of DNS zones to create (public/private) | <pre>list(object({<br/>    name = string<br/>    type = string # public or private<br/>  }))</pre> | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Deployment environment | `string` | `""` | no |
| <a name="input_location"></a> [location](#input\_location) | Azure Region | `string` | `""` | no |
| <a name="input_private_a_records"></a> [private\_a\_records](#input\_private\_a\_records) | List of private a records | <pre>map(object({<br/>    name = string<br/>    ip   = string<br/>    ttl  = number<br/>    zone = string<br/>  }))</pre> | n/a | yes |
| <a name="input_private_aaaa_records"></a> [private\_aaaa\_records](#input\_private\_aaaa\_records) | List of AAAA records for the private DNS zone | `list(object({ name = string, ipv6 = string, ttl = number }))` | `[]` | no |
| <a name="input_private_cname_records"></a> [private\_cname\_records](#input\_private\_cname\_records) | List of CNAME records for the private DNS zone | `list(object({ name = string, target = string, ttl = number }))` | `[]` | no |
| <a name="input_private_mx_records"></a> [private\_mx\_records](#input\_private\_mx\_records) | List of MX records for the private DNS zone | <pre>list(object({<br/>    name  = string,<br/>    prefs = list(number),<br/>    hosts = list(string),<br/>    ttl   = number<br/>  }))</pre> | `[]` | no |
| <a name="input_private_srv_records"></a> [private\_srv\_records](#input\_private\_srv\_records) | List of SRV records for the private DNS zone | <pre>list(object({<br/>    name = string,<br/>    ttl  = number,<br/>    records = list(object({<br/>      priority = number,<br/>      weight   = number,<br/>      port     = number,<br/>      target   = string<br/>    }))<br/>  }))</pre> | `[]` | no |
| <a name="input_private_txt_records"></a> [private\_txt\_records](#input\_private\_txt\_records) | List of TXT records for the private DNS zone | `list(object({ name = string, values = list(string), ttl = number }))` | `[]` | no |
| <a name="input_public_a_records"></a> [public\_a\_records](#input\_public\_a\_records) | List of public a records) | <pre>map(object({<br/>    name = string<br/>    ip   = string<br/>    ttl  = number<br/>    zone = string<br/>  }))</pre> | n/a | yes |
| <a name="input_public_aaaa_records"></a> [public\_aaaa\_records](#input\_public\_aaaa\_records) | List of AAAA records for the public DNS zone | `list(object({ name = string, ipv6 = string, ttl = number }))` | `[]` | no |
| <a name="input_public_cname_records"></a> [public\_cname\_records](#input\_public\_cname\_records) | List of CNAME records for the public DNS zone | `list(object({ name = string, target = string, ttl = number }))` | `[]` | no |
| <a name="input_public_mx_records"></a> [public\_mx\_records](#input\_public\_mx\_records) | List of MX records for the public DNS zone | <pre>list(object({<br/>    name  = string,<br/>    prefs = list(number),<br/>    hosts = list(string),<br/>    ttl   = number<br/>  }))</pre> | `[]` | no |
| <a name="input_public_srv_records"></a> [public\_srv\_records](#input\_public\_srv\_records) | List of SRV records for the public DNS zone | <pre>list(object({<br/>    name = string,<br/>    ttl  = number,<br/>    records = list(object({<br/>      priority = number,<br/>      weight   = number,<br/>      port     = number,<br/>      target   = string<br/>    }))<br/>  }))</pre> | `[]` | no |
| <a name="input_public_txt_records"></a> [public\_txt\_records](#input\_public\_txt\_records) | List of TXT records for the public DNS zone | `list(object({ name = string, values = list(string), ttl = number }))` | `[]` | no |
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | Azure Subscription ID | `string` | `""` | no |
| <a name="input_vnet_id"></a> [vnet\_id](#input\_vnet\_id) | Virtual Network ID to link to the private DNS zone (if enabled) | `string` | `""` | no |
| <a name="input_vnet_links"></a> [vnet\_links](#input\_vnet\_links) | List of virtual networks to link to the private DNS zone.<br/>Each object must include:<br/>- name: Unique name for the DNS link<br/>- vnet\_id: The full Azure resource ID of the virtual network | <pre>list(object({<br/>    name    = string<br/>    vnet_id = string<br/>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_private_dns_zones"></a> [private\_dns\_zones](#output\_private\_dns\_zones) | Map of private DNS zones created |
| <a name="output_public_dns_zones"></a> [public\_dns\_zones](#output\_public\_dns\_zones) | Map of public DNS zones created |
| <a name="output_vnet_link_names"></a> [vnet\_link\_names](#output\_vnet\_link\_names) | Names of the virtual network links created |
| <a name="output_vnet_links"></a> [vnet\_links](#output\_vnet\_links) | Map of private DNS zone virtual network links |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
