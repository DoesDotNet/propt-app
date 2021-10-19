resource "azurerm_frontdoor" "app" {
  name                                         = format("propt-app-%s-ukso-fd", var.environment)
  resource_group_name                          = azurerm_resource_group.app.name
  enforce_backend_pools_certificate_name_check = false

  tags = local.common_tags

  routing_rule {
    name               = "exampleRoutingRule1"
    accepted_protocols = ["Http", "Https"]
    patterns_to_match  = ["/*"]
    frontend_endpoints = [format("propt-app-%s-ukso-fd", var.environment)]
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
      host_header = azurerm_storage_account.app.primary_web_host
      address     = azurerm_storage_account.app.primary_web_host
      http_port   = 80
      https_port  = 443
    }

    load_balancing_name = "propt-app-load-balancing"
    health_probe_name   = "propt-app-health-probe"
  }

  frontend_endpoint {
    name                     = format("propt-app-%s-ukso-fd", var.environment)
    host_name                = format("propt-app-%s-ukso-fd.azurefd.net", var.environment)
    session_affinity_enabled = false
  }
}