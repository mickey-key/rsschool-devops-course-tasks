resource "aws_security_group" "public_sg" {
  name   = "public sg"
  vpc_id = aws_vpc.rs_course_task_2_vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "to allow all outbound traffic"

  }

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "public sg"
  }
}

resource "aws_security_group" "private_sg" {
  name        = "private sg"
  description = "Allow traffic from public subnet"
  vpc_id      = aws_vpc.rs_course_task_2_vpc.id

  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = -1
    security_groups = [aws_security_group.public_sg.id]
    description     = "to allow inbound traffic from public subnets"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
    description = "to allow all outbound traffic"
  }

  tags = {
    Name = "private sg"
  }
}

#todo: Configure the private Linux instance's security group to accept SSH connections only from the bastion host.
#todo optional: Configure the bastion host's security group to allow SSH connections (TCP/22) from only known and trusted IP addresses.

