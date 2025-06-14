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

resource "aws_s3_bucket" "bucket" {
  bucket = "rsschool-first-task-bucket"
}
