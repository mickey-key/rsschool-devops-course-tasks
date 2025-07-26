terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }

  backend "s3" {
    bucket  = "terraform-states-for-rs"
    key     = "task_2.tfstate"
    region  = "eu-west-1"
    encrypt = true
  }
}
