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

resource "aws_s3_bucket" "first-task-bucket" {
  bucket = "lab_1"
}
