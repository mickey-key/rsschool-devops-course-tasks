resource "aws_network_acl" "network_acl_private_subnet" {
  vpc_id = aws_vpc.rs_course_task_2_vpc.id
  ingress {
    rule_no    = 100
    action     = "allow"
    protocol   = "icmp"
    icmp_type  = -1
    icmp_code  = -1
    from_port  = 0
    to_port    = 0
    cidr_block = "0.0.0.0/0"
  }
  ingress {
    rule_no    = 120
    action     = "allow"
    protocol   = "tcp"
    from_port  = 22
    to_port    = 22
    cidr_block = "0.0.0.0/0"
  }

  egress {
    rule_no    = 100
    action     = "allow"
    protocol   = "-1"
    from_port  = 0
    to_port    = 0
    cidr_block = "0.0.0.0/0"
  }
}
resource "aws_network_acl" "network_acl_public_subnet" {
  vpc_id = aws_vpc.rs_course_task_2_vpc.id
  ingress {
    rule_no    = 100
    action     = "allow"
    protocol   = "icmp"
    icmp_type  = -1
    icmp_code  = -1
    from_port  = 0
    to_port    = 0
    cidr_block = "0.0.0.0/0"
  }
  ingress {
    rule_no    = 120
    action     = "allow"
    protocol   = "tcp"
    from_port  = 22
    to_port    = 22
    cidr_block = "0.0.0.0/0"
  }
  ingress {
    rule_no    = 130
    action     = "allow"
    protocol   = "tcp"
    from_port  = 1024
    to_port    = 65535
    cidr_block = "0.0.0.0/0"
  }
  egress {
    rule_no    = 100
    action     = "allow"
    protocol   = "-1"
    from_port  = 0
    to_port    = 0
    cidr_block = "0.0.0.0/0"
  }

}


resource "aws_network_acl_association" "acl_associations_private_subnet" {
  count          = length(aws_subnet.private_subnets)
  subnet_id      = aws_subnet.private_subnets[count.index].id
  network_acl_id = aws_network_acl.network_acl_private_subnet.id
}


resource "aws_network_acl_association" "acl_associations_public_subnet" {
  count          = length(aws_subnet.public_subnets)
  subnet_id      = aws_subnet.public_subnets[count.index].id
  network_acl_id = aws_network_acl.network_acl_public_subnet.id
}
