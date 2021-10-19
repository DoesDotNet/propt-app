resource "azurerm_frontdoor" "app" {
  name                                         = format("propt-app-%s-ukso-fd", var.environment)
  resource_group_name                          = azurerm_resource_group.app.name
  enforce_backend_pools_certificate_name_check = false

  tags = local.common_tags

  routing_rule {
    name               = "exampleRoutingRule1"
    accepted_protocols = ["Http", "Https"]
    patterns_to_match  = ["/*"]
    frontend_endpoints = ["propt-app"]
    forwarding_configuration {
      forwarding_protocol = "MatchRequest"
      backend_pool_name   = "propt-app-backend"
    }
  }

  backend_pool_load_balancing {
    name = "propt-app-load-balancing"
  }

  backend_pool_health_probe {
    name = "propt-app-health-probe"
  }

  backend_pool {
    name = "propt-app-backend"
    backend {
      host_header = azurerm_storage_account.app.primary_web_endpoint
      address     = azurerm_storage_account.app.primary_web_endpoint
      http_port   = 80
      https_port  = 443
    }

    load_balancing_name = "propt-app-load-balancing"
    health_probe_name   = "propt-app-health-probe"
  }

  frontend_endpoint {
    name      = "propt-app"
    host_name = "propt-app-test.azurefd.net"
  }
}