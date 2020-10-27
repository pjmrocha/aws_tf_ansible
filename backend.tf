terraform {
  required_version = ">=0.12.0"
  backend "s3" {
    region  = "eu-west-2"
    profile = "tf-user"
    key     = "terraform.statefile"
    bucket  = "terraform-bucket-pjm-2020"
  }
}
