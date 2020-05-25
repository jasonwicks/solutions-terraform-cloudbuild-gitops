
resource "google_cloudbuild_trigger" "trigger_jw-ecp-cb" {
  
  name        = "jw-ecp-cb-${var.envdir}-plan-apply"
  description = "Standard trigger to execute level 3 pipeline for project anz-team-app"

  project     = "${module.jw-ecp-cb.project_id}"  
  disabled    = "${var.is_prod ? true : false}"
  filename    = "${var.cloudbuild_yaml}"
 
 
  /*
  ** Note: ** is a recursive version of * which matches all files and directories in the selected directory and its subdirectories.
  ** For example, the pattern src/* will match src/code.py, but will ignore src/sub/code.py whereas src/** will match both.
  */
  included_files = ["projects/jw-ecp-cb/**"]
  ignored_files  = ["projects/jw-ecp-cb/prod/**"]  # Ignore any changes to production folder to avoid kicking off pipeline when commits don't impact nonprod folder.
   
  trigger_template {
    branch_name = ".*"                     # We can execute trigger for all code changes, and determine in cloudbuild.yaml file to either plan or plan and apply
    repo_name   = "${var.repository}"
  }
 
 
  # Below is an example of how to pass variables into the cloudbuild.yaml file to add more powerful logic.
  substitutions = {
    _PROJECT_ID              = "module.project.project_id"
    _PROJECT                 = "project/jw-ecp-cb"      # path to project directory
    _ENVDIR                  = "${var.envdir}"             # prod or nonprod
    _RUN_TERRAFORM_APPLY     = "1"                         #
    _TERRAFORM_VERSION       = "${var.terraform_version}"  # Selects version of terraform to run.  Currently 11.8
    _GCP_ORG                 = "${var.organisation}"                # GCP org - anzcom, anznpcom, onedirect
    _BACKEND                 = "anzod-tf-state-931373029707"
  }

}