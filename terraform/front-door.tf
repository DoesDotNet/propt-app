resource "azurerm_frontdoor" "app" {
  name                                         = local.frontdoor_name
  resource_group_name                          = azurerm_resource_group.app.name
  enforce_backend_pools_certificate_name_check = false

  tags = local.common_tags

  frontend_endpoint {
    name                     = local.frontdoor_name
    host_name                = local.frontdoor_hostname
    session_affinity_enabled = false
  }

  frontend_endpoint {
    name                     = "app"
    host_name                = format("app-%s.propt.me", var.environment)
    session_affinity_enabled = false
  }

  routing_rule {
    name               = "app-route-https"
    accepted_protocols = ["Https"]
    patterns_to_match  = ["/*"]
    frontend_endpoints = ["app"]
    forwarding_configuration {
      forwarding_protocol = "MatchRequest"
      backend_pool_name   = "propt-app-backend"
    }
  }

  routing_rule {
    name               = "app-route-http"
    accepted_protocols = ["Http"]
    patterns_to_match  = ["/*"]
    frontend_endpoints = ["app"]
    redirect_configuration {
      redirect_protocol = "HttpOnly"
      redirect_type = "PermanentRedirect"
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

  
}

resource "azurerm_frontdoor_custom_https_configuration" "app" {
  frontend_endpoint_id              = azurerm_frontdoor.app.frontend_endpoint[0].id
  custom_https_provisioning_enabled = false
}
