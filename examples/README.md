# Module Example

Example of how to use the DNS module to create Azure public and private DNS zones and various records.

## Configuration

```hcl
module "dns" {
  source = "../../modules/dns"

  location             = "eastus"
  resource_group_name  = "rg-dns-example"
  dns_zones            = ["dev.example.com", "private.example.com"]
  default_tags         = {
    environment = "dev"
    project     = "dns-setup"
  }

  public_a_records = [
    {
      name  = "www"
      ttl   = 300
      ip    = "40.1.2.3"
      zone  = "dev.example.com"
    }
  ]

  private_cname_records = [
    {
      name   = "db"
      ttl    = 300
      target = "db-internal.local"
      zone   = "private.example.com"
    }
  ]

  public_txt_records = [
    {
      name   = "verify"
      ttl    = 600
      values = ["google-site-verification=abc123"]
      zone   = "dev.example.com"
    }
  ]

  vnet_links = [
    {
      name    = "link-to-hub"
      vnet_id = "/subscriptions/xxxx/resourceGroups/rg-hub/providers/Microsoft.Network/virtualNetworks/vnet-hub"
    }
  ]
}