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
