module "anz-team-app3" {
  source = "../modules/common"

  suffix  = "${var.suffix}"
  organisation = "${var.organisation}"

  region    = "${var.region}"
  folder_id = "${var.folder_id}"

  billing_account_id   = "${var.billing_account_id}"

}
