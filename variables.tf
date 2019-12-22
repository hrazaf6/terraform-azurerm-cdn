variable "resource_group_name" {}
variable "name" {}
variable "tier" {}
variable "cdn_provider" {}
variable "enable_endpoint" {
    type = bool
}
variable "origin_hostnames" {
    type = list(string)
}
variable "tags" {
  type        = map(string)
  default     = {}
  description = "A mapping of tags to assign to the cdn profile."
}

locals {
    cdn_name = format("%s-cdn", var.name)
    endpoint_name = format("%s-endpoint", var.name)
    enable_endpoint = var.enable_endpoint

    sku_provider = {
        "standard" = ["Akamai", "Microsoft", "Verizon"]
        "premium" = ["Verizon"]
    }

    provider = title(var.cdn_provider)

    is_provider = contains(local.sku_provider[var.tier], local.provider)

    sku = local.is_provider ? format("%s_%s", title(var.tier), local.provider) : "Right Tier/Provider has not been provided"

}