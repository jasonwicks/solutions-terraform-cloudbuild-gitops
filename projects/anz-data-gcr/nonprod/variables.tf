variable "region" {
  description = "GCP region name."
}

variable "folder_id" {
  description = "The ID of the Google Cloud Organization Folder."
}

variable "billing_account_id" {
  description = "The ID of the associated billing account (optional)."
}

variable "suffix" {
  description = "Environment short suffix (prod, np, etc)"
}

variable "organisation" {
  description = "GCP organisation where project is created"
}

variable "state_bucket_project_id" {
  description   = "The project to create the state bucket in. This should be a secure project with no inherited storage permissions. If left blank, will default to service project."
}
