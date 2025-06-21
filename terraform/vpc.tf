resource "aws_vpc" "rs_course_task_2_vpc" {
  cidr_block = var.vpc_cidr_block
  #  enable_dns_support   = true
  #  enable_dns_hostnames = true
  tags = {
    Name = "rs_course_task_2_vpc"
  }
}
