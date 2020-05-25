variable "region" {
  description = "GCP region name."
  default = "australia-southeast1"
}

variable "billing_account_id" {
  description = "Billing account assigned to the service project"
}

variable "organisation" {
  description = "GCP organisation where project is created"
}

variable "suffix" {
  description = "Environment short suffix (prod, np, etc)"
}

variable "folder_id" {
  description = "GCP folder_id in which to place project"
}

variable "is_prod" {
  description = "set to 1 for prod, 0 for nonprod"
}

variable "cloudbuild_yaml" {
  description = "location of cloudbuild yaml file in repository"
}

variable "repository" {
  description = "name of source repository"
}

variable "envdir" {
  description = "set to prod for prod and nonprod for nonprod"
}

variable "terraform_version" {
  description = "string of terraform binary to use"
}
