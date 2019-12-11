terraform {
  backend "gcs" {
    bucket  = "terraform-state-test"
    prefix  = "test"
    credentials = "gcp.json"
  }
}

data "terraform_remote_state" "foo" {
  backend = "gcs"
  config = {
    bucket  = "terraform-state-test"
    prefix  = "test"
  }
}