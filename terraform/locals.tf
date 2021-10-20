locals {
  common_tags = {
    environment = "${var.environment}"
    project     = "${var.project}"
    system      = "${var.system}"
  }

  frontdoor_name = format("propt-app-%s-ukso-fd", var.environment)
  frontdoor_hostname = format("propt-app-%s-ukso-fd.azurefd.net", var.environment)
}