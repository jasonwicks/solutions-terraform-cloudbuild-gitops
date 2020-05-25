locals {
  env = "${terraform.workspace}"
}


module "project" {
  source = "git::https://github.service.anz/ics/terraform-gcp-modules.git//project?ref=project/2.2.1"

  app_name          = "cloudbuild-poc-2"
  bsb_cc            = "39970246"
  environment       = "${local.env}"
  project_name      = "jw-ecp-cb-${var.suffix}"
  domain            = "ecp"
  tribe             = "cloud_platform"
  category          = "shared_services"
  owneremail        = "vamshi_krishnayr_anz_com"
  organisation      = "${var.organisation}"
  uuid              = "na"

  region = "${var.region}"
  folder_id = "${var.folder_id}"

  project_initial_name = "jw-ecp-cb-${var.suffix}"
  billing_account_id = "${var.billing_account_id}"

}

# Need a bucket for cloud build logs.
resource "google_storage_bucket" "cloudbuild-log-bucket" {
  name     = "${module.project.project_id}-cloudbuild-log-bucket"
  location = "australia-southeast1"
  force_destroy = "true"
  project  = "${module.project.project_id}"
  versioning {
    enabled = true
  }
}


# Enable BigQuery API in service project
resource "google_project_service" "cloudbuild" {
  project = "${module.project.project_id}"
  service = "cloudbuild.googleapis.com",
  disable_on_destroy = false
}

resource "google_project_service" "sourcerepo" {
  project = "${module.project.project_id}"
  service = "sourcerepo.googleapis.com",
  disable_on_destroy = false
}

resource "google_sourcerepo_repository" "my-repo" {
  name = "${var.repository}"
  project = "${module.project.project_id}"
}
module "pubsub" {
  source = "git::https://github.service.anz/ics/terraform-gcp-modules.git//project-pubsub?ref=project/2.2.1"

  project_id      = "${module.project.project_id}"
  service_account = "${module.project.project_service_account}"
}
