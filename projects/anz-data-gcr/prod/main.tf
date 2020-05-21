module "anz-data-gcr" {
  source = "../modules/common"

  suffix  = "${var.suffix}"

  organisation = "${var.organisation}"

  region    = "${var.region}"
  folder_id = "${var.folder_id}"

  billing_account_id   = "${var.billing_account_id}"

  state_bucket_project_id = "${var.state_bucket_project_id}"
}
