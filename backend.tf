terraform {
  backend "gcs" {
    bucket  = "terraform-state-test"
    prefix  = "test"
  }
}

data "terraform_remote_state" "foo" {
  backend = "gcs"
  config = {
    bucket  = "terraform-state-test"
    prefix  = "test"
    credentials = var.backendCreds
  }
}