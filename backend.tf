terraform {
  backend "s3" {
    bucket         = "reggie-testing-bucket"
    key            = "RDS_Database/terraform.tfstates"
    dynamodb_table = "terraform-lock"
  }
}