locals {
  env = "${terraform.workspace}"
}


module "project" {
  source = "git::https://github.service.anz/ics/terraform-gcp-modules.git//project?ref=project/2.1.0"

  app_name          = "ecp_monitoring"
  bsb_cc            = "39970246"
  environment       = "${local.env}"
  project_name      = "anz-ecp-mon-${var.suffix}"
  domain            = "ecp"
  tribe             = "cloud_platform"
  category          = "shared_services"
  owneremail        = "vamshi_krishnayr_anz_com"
  organisation      = "${var.organisation}"
  uuid              = "na"

  region = "${var.region}"
  folder_id = "${var.folder_id}"

  project_initial_name = "anz-ecp-mon-${var.suffix}"
  billing_account_id = "${var.billing_account_id}"

}

module "pubsub" {
  source = "git::https://github.service.anz/ics/terraform-gcp-modules.git//project-pubsub?ref=project/2.1.0"

  project_id      = "${module.project.project_id}"
  service_account = "${module.project.project_service_account}"
}
