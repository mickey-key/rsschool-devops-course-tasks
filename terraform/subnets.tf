resource "aws_subnet" "private_subnets" {
  count             = length(var.privat_subnets_cidr)
  vpc_id            = aws_vpc.rs_course_task_2_vpc.id
  cidr_block        = element(var.privat_subnets_cidr, count.index)
  availability_zone = element(var.availability_zones, count.index)

  tags = {
    Name = "private-subnet-${count.index + 1}"
  }
}


resource "aws_subnet" "public_subnets" {
  count                   = length(var.public_subnets_cidr)
  vpc_id                  = aws_vpc.rs_course_task_2_vpc.id
  cidr_block              = element(var.public_subnets_cidr, count.index)
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet-${count.index + 1} "
  }
}


