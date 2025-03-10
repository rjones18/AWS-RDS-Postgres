variable "vpc_name" {
  description = "Name of the vpc for my project"
  type        = string
}

variable "data_a_subnet_name" {
  type = string
}

variable "data_b_subnet_name" {
  type = string
}

variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "us-west-2"
}

variable "s3_bucket_name" {
  description = "S3 Bucket Name for Lambda Exports"
  type        = string
  default     = "my-lambda-export-bucket"
}

variable "lambda_layer_s3_bucket" {
  description = "S3 Bucket for storing Lambda Layers"
  type        = string
  default     = "reggie-lambda-layers-bucket"
}

variable "aws_account_id" {
  description = "AWS Account ID"
  type        = string
  default = "014498625953"
}

variable "rds_instance_id" {
  description = "RDS Instance ID"
  type        = string
  default = "edu"
}

