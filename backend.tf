terraform {
  backend "s3" {
    bucket         = "reggie-talent-academy-686520628199-tfstates"
    key            = "Talent-Academy/labs/RDS_Database_2/terraform.tfstates"
    dynamodb_table = "terraform-lock"
  }
}