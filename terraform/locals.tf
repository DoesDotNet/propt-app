locals {
  common_tags = {
    environment = "${var.environment}"
    project     = "${var.project}"
    system      = "${var.system}"
  }

  frontdoor_name     = format("%s-%s-%s-ukso-fd", var.project, var.system, var.environment)
  frontdoor_hostname = format("%s-%s-%s-ukso-fd.azurefd.net", var.project, var.system, var.environment)

  frontdoor_app_host = var.environment == "live" ? "app.propt.me" : format("app-%s.propt.me", var.environment)
}