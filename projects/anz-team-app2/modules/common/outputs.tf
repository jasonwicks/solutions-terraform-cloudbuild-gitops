output "project_id" {
  value = "${module.project.project_id}"
}

output "service_account" {
  value = "${module.project.project_service_account}"
}

output "terraform_state_bucket" {
  value = "${module.project.terraform_state_bucket}"
}
