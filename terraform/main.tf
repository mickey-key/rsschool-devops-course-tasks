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

resource "aws_s3_bucket" "task1_bucket" {
  bucket = "first-rsschool-task-bucket"
}
