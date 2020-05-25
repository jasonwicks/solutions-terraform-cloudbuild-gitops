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

