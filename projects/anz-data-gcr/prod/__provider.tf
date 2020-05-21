# Explicitly require provider.null, this is required when removing a null resource from configuration. `provider.null`
# referenced in state but not referenced in code.
# Error observed: `provider.null: no suitable version installed`
provider "null" {
  version = "~> 2.0"
}

provider "google" {
  region  = "${var.region}"
  version = "2.9.1"
}

provider "google-beta" {
  region  = "${var.region}"
  version = "2.9.1"
}

terraform {
  required_version = "0.11.8"

  backend "gcs" {}
}
