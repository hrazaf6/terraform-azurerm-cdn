data "azurerm_resource_group" "this" {
    name = var.resource_group_name
}

resource "azurerm_cdn_profile" "this" {
  name                = local.cdn_name
  location            = data.azurerm_resource_group.this.location
  resource_group_name = data.azurerm_resource_group.this.name
  sku                 = local.sku

  tags = var.tags
}

resource "azurerm_cdn_endpoint" "this" {
  count               = local.enable_endpoint == true ? 1 : 0
  name                = local.endpoint_name
  profile_name        = azurerm_cdn_profile.this.name
  location            = data.azurerm_resource_group.this.location
  resource_group_name = data.azurerm_resource_group.this.name

  dynamic "origin" {
    for_each  = var.origin_hostnames
    iterator = hostname

    content {
        name       = local.endpoint_name
        host_name  = hostname.value
        http_port  = 80
        https_port = 443
    }
  }
  lifecycle {
    create_before_destroy = true
  }
}

