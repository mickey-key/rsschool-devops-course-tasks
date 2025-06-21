resource "aws_instance" "public_ec2_instance" {
  # for_each = aws_subnet.public_subnets
  ami                    = var.instance_ami
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.public_sg.id]
  # subnet_id = each.value.id
  subnet_id = aws_subnet.public_subnets[0].id
  key_name  = var.ssh_keyname
  tags = {
    #Name = "public_ec2_instance_${each.key}"
    Name = "public_ec2 - ${aws_subnet.public_subnets[0].id}"
  }
  depends_on = [aws_subnet.public_subnets]
}

resource "aws_instance" "private_ec2_instance" {
  #for_each = aws_subnet.private_subnets
  ami                    = var.instance_ami
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.private_sg.id]
  #subnet_id = each.value.id
  subnet_id = aws_subnet.private_subnets[0].id
  key_name  = var.ssh_keyname
  tags = {
    #   Name = "private_ec2_instance_${each.key}"
    Name = "private_ec2_instance_${aws_subnet.private_subnets[0].id}"
  }
  depends_on = [aws_subnet.private_subnets]
}
