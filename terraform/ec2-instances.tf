#bastion is in the first public subnet [0], publix host is in [1]

resource "aws_instance" "public_ec2_instance_b" {
  ami                         = var.instance_ami
  instance_type               = var.instance_type
  security_groups             = [aws_security_group.public_sg.id]
  subnet_id                   = aws_subnet.public_subnets[1].id
  key_name                    = var.ssh_keyname
  associate_public_ip_address = true
  tags = {
    Name = "public_ec2_instance_${aws_subnet.public_subnets[1].id}"
  }
  depends_on = [aws_subnet.public_subnets]
}

resource "aws_instance" "private_ec2_instance_k3s_master" {
  ami             = var.instance_ami
  instance_type   = var.instance_type
  security_groups = [aws_security_group.private_sg.id]
  #subnet_id       	= each.value.id
  subnet_id = aws_subnet.private_subnets[0].id
  key_name  = var.ssh_keyname
  tags = {
    Name = "private_ec2_instance_${aws_subnet.private_subnets[0].id}"

  }
  user_data = <<-EOF
              #!/bin/bash
              curl -sfL https://get.k3s.io | K3S_TOKEN=${var.token_k3s} sh - 
              sudo chmod 644 /etc/rancher/k3s/k3s.yaml
              EOF

  user_data_replace_on_change = true
  depends_on                  = [aws_subnet.private_subnets]
}


resource "aws_instance" "private_ec2_instance_k3s_agent" {
  ami             = var.instance_ami
  instance_type   = var.instance_type
  security_groups = [aws_security_group.private_sg.id]
  subnet_id       = aws_subnet.private_subnets[1].id
  key_name        = var.ssh_keyname
  tags = {
    Name = "private_ec2_instance_${aws_subnet.private_subnets[1].id}"
  }
  user_data = <<-EOF
              #!/bin/bash
              curl -sfL https://get.k3s.io | K3S_URL=https://${aws_instance.private_ec2_instance_k3s_master.private_ip}:6443 K3S_TOKEN=${var.token_k3s} sh -
              sudo chmod 644 /etc/rancher/k3s/k3s.yaml
              EOF

  user_data_replace_on_change = true
  depends_on                  = [aws_subnet.private_subnets, aws_instance.private_ec2_instance_k3s_master]
}


