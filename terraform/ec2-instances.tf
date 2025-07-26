resource "aws_instance" "public_ec2_instance" {
  ami                         = var.instance_ami
  instance_type               = var.instance_type
  security_groups             = [aws_security_group.public_sg.id]
  subnet_id                   = aws_subnet.public_subnets[0].id
  key_name                    = var.ssh_keyname
  associate_public_ip_address = true
  tags = {
    Name = "public_ec2_instance_${aws_subnet.public_subnets[0].id}"
  }

   root_block_device {
    volume_size = 16
    delete_on_termination = true
   }

  user_data =  file("k3s_config.sh") 
  depends_on = [aws_subnet.public_subnets]

  # Connection is necessary for file provisioner to work
  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ubuntu"
    private_key = file("/home/mickey/Downloads/key.pem1")
    timeout     = "2m"
  }
}


resource "aws_internet_gateway" "internet_gw" {
  vpc_id = aws_vpc.rs_course_vpc.id

  tags = {
    Name = "main internet gateway"
  }
}

#route tables for public subnets 
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.rs_course_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gw.id
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
