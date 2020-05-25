provider "google" {
  region  = "${var.region}"
  version = "2.20.0"
}

provider "google-beta" {
  region  = "${var.region}"
  version ="2.20.0"
}

terraform {
  required_version = "0.11.14"

  backend "gcs" {
  }
}
