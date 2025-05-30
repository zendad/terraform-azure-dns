variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
  default     = ""
}

variable "location" {
  description = "Azure Region"
  type        = string
  default     = ""
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = ""
}

variable "default_tags" {
  description = "Default tags for all resources"
  type        = map(string)
  default     = {}
}

variable "dns_zones" {
  description = "List of DNS zones to create (public/private)"
  type = list(object({
    name = string
    type = string # public or private
  }))
}

variable "create_vnet_link" {
  description = "Whether to create a private DNS zone virtual network link"
  type        = bool
  default     = false
}

variable "vnet_id" {
  description = "Virtual Network ID to link to the private DNS zone (if enabled)"
  type        = string
  default     = ""
}

# Record Variables

variable "public_a_records" {
  description = "List of public a records)"
  type = map(object({
    name = string
    ip   = string
    ttl  = number
    zone = string
  }))
}

variable "private_a_records" {
  description = "List of private a records"
  type = map(object({
    name = string
    ip   = string
    ttl  = number
    zone = string
  }))
}

variable "public_aaaa_records" {
  description = "List of AAAA records for the public DNS zone"
  type        = list(object({ name = string, ipv6 = string, ttl = number }))
  default     = []
}

variable "private_aaaa_records" {
  description = "List of AAAA records for the private DNS zone"
  type        = list(object({ name = string, ipv6 = string, ttl = number }))
  default     = []
}

variable "public_cname_records" {
  description = "List of CNAME records for the public DNS zone"
  type        = list(object({ name = string, target = string, ttl = number }))
  default     = []
}

variable "private_cname_records" {
  description = "List of CNAME records for the private DNS zone"
  type        = list(object({ name = string, target = string, ttl = number }))
  default     = []
}

variable "public_txt_records" {
  description = "List of TXT records for the public DNS zone"
  type        = list(object({ name = string, values = list(string), ttl = number }))
  default     = []
}

variable "private_txt_records" {
  description = "List of TXT records for the private DNS zone"
  type        = list(object({ name = string, values = list(string), ttl = number }))
  default     = []
}

variable "public_mx_records" {
  description = "List of MX records for the public DNS zone"
  type = list(object({
    name  = string,
    prefs = list(number),
    hosts = list(string),
    ttl   = number
  }))
  default = []
}

variable "private_mx_records" {
  description = "List of MX records for the private DNS zone"
  type = list(object({
    name  = string,
    prefs = list(number),
    hosts = list(string),
    ttl   = number
  }))
  default = []
}

variable "public_srv_records" {
  description = "List of SRV records for the public DNS zone"
  type = list(object({
    name = string,
    ttl  = number,
    records = list(object({
      priority = number,
      weight   = number,
      port     = number,
      target   = string
    }))
  }))
  default = []
}

variable "private_srv_records" {
  description = "List of SRV records for the private DNS zone"
  type = list(object({
    name = string,
    ttl  = number,
    records = list(object({
      priority = number,
      weight   = number,
      port     = number,
      target   = string
    }))
  }))
  default = []
}

variable "vnet_links" {
  description = <<DESC
List of virtual networks to link to the private DNS zone.
Each object must include:
- name: Unique name for the DNS link
- vnet_id: The full Azure resource ID of the virtual network
DESC
  type = list(object({
    name    = string
    vnet_id = string
  }))
  default = []
}
