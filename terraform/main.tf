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

resource "aws_s3_bucket" "lab_1_bucket" {
  bucket = "lab_1"
  acl    = "private"
}