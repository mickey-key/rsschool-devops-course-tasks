resource "aws_internet_gateway" "t2_igw" {
  vpc_id = aws_vpc.rs_course_task_2_vpc.id

  tags = {
    Name = "IG-for-task2"
  }
}

#route tables for public subnets 
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.rs_course_task_2_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.t2_igw.id
  }
  tags = {
    Name = "public_route_able"
  }
}

# from public subnet to IG 
resource "aws_route_table_association" "public_rt_association" {
  count          = length(aws_subnet.public_subnets)
  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.public_rt.id
}


resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.rs_course_task_2_vpc.id

  tags = {
    Name = "private_route_table"
  }
}
resource "aws_route_table_association" "private_rt_association" {
  count          = length(aws_subnet.private_subnets)
  subnet_id      = aws_subnet.private_subnets[count.index].id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route" "private_nat_route" {
  route_table_id         = aws_route_table.private_rt.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gateway.id
  depends_on             = [aws_nat_gateway.nat_gateway]
}




resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.elastic_ip.id
  subnet_id     = aws_subnet.public_subnets[0].id
  tags = {
    Name = "NAT_gateway"
  }
  depends_on = [aws_internet_gateway.t2_igw, aws_eip.elastic_ip]
}

resource "aws_eip" "elastic_ip" {
  domain = "vpc"
  tags = {
    Name = "ElasticIP for NAT"
  }
}

