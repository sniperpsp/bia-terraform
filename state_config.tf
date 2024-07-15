terraform {
  backend "s3" {
    bucket = "bucket-teste124"
    key = "terraformstate/terraform.tfstate"
    region = "us-east-1"
    profile = "bia"
  }
}