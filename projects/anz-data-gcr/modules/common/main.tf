locals {
  env = "${terraform.workspace}"
}

module "project" {
  source = "git::https://github.service.anz/ics/terraform-gcp-modules.git//project?ref=project/2.2.0"

  app_name     = "cde"
  bsb_cc       = "38130129"
  environment  = "${local.env}"
  project_name = "anz-data-gcr"
  domain       = "data"
  tribe        = "data_services"
  category     = "business"
  owneremail   = "russell_diery_anz_com"
  organisation = "${var.organisation}"
  uuid         = "1ddb9308-7c8c-4307-b2cf-e32f1e4596db"

  region    = "${var.region}"
  folder_id = "${var.folder_id}"

  project_initial_name = "anz-data-gcr"
  billing_account_id   = "${var.billing_account_id}"

  state_bucket_project_id = "${var.state_bucket_project_id}"
}

module "project-container-analysis" {
  source     = "git::https://github.service.anz/ics/terraform-gcp-modules.git//project-container-analysis?ref=5c4273e"

  service_project_id = "${module.project.project_id}"
}
