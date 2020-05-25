resource "google_cloudbuild_trigger" "trigger_project_bootstrap" {
  name        = "foundation-project-bootstrap"
  description = "Used to do initial build of new triggers for new projects - POC."

  project  = "${module.jw-ecp-cb.project_id}"
  disabled = "${var.is_prod ? true : false}"
  filename = "${var.cloudbuild_yaml}"

  /*
    ** Note: ** is a recursive version of * which matches all files and directories in the selected directory and its subdirectories.
    ** For example, the pattern src/* will match src/code.py, but will ignore src/sub/code.py whereas src/** will match both.
    */
  included_files = ["projects/**/platform_pipeline/**"]

  trigger_template {
    branch_name = "^master$"                # We can execute trigger for all code changes, and determine in cloudbuild.yaml file to either plan or plan and apply
    repo_name   = "${var.repository}"
  }

  # Below is an example of how to pass variables into the cloudbuild.yaml file to add more powerful logic.
  substitutions = {
    _PROJECT             = "project/jw-ecp-cb"           # path to project directory
    _ENVDIR              = "${var.envdir}"               # prod or nonprod
    _RUN_TERRAFORM_APPLY = "1"                           #
    _TERRAFORM_VERSION   = "${var.terraform_version}"    # Selects version of terraform to run.  Currently 11.8
    _GCP_ORG             = "${var.organisation}"         # GCP org - anzcom, anznpcom, onedirect
    _BACKEND             = "anzod-tf-state-931373029707"
  }
}
