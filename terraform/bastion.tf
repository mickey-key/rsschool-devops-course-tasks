resource "aws_instance" "bastion_host" {
  ami           = var.instance_ami
  instance_type = var.instance_type
  #availability_zone = element(data.aws_availability_zones.available.names, 0)
  subnet_id                   = aws_subnet.public_subnets[0].id
  associate_public_ip_address = true

  key_name               = var.ssh_keyname
  vpc_security_group_ids = [aws_security_group.public_sg.id]
  user_data              = <<-EOF
              #!/bin/bash
              mkdir -p /home/ec2-user/.ssh/
              echo "${var.private_key_pem}" > /home/ec2-user/.ssh/private_key.pem
              chmod 400 /home/ec2-user/.ssh/private_key.pem
              chown ec2-user:ec2-user /home/ec2-user/.ssh/private_key.pem
              EOF


  tags = {
    Name = "Bastion Host"
  }
}

