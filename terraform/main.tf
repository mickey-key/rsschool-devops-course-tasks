terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = var.regions
}

resource "aws_s3_bucket" "lab1-bucket" {
  bucket = "lab_1"
  aws_s3_bucket_acl    = "private"
}
