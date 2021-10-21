locals {
  common_tags = {
    environment = "${var.environment}"
    project     = "${var.project}"
    system      = "${var.system}"
  }

  name_prefix = "${var.project}-${var.system}-${var.environment}"

  storage_name_prefix = "${var.project}${var.system}${var.environment}"
  frontdoor_name      = format("%s-fd", local.name_prefix)
  frontdoor_hostname  = format("%s.azurefd.net", local.frontdoor_name)

  frontdoor_app_host = var.environment == "live" ? "app.propt.me" : format("app-%s.propt.me", var.environment)
}