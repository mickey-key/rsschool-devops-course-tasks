output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.rs_course_task_2_vpc.id
}

output "public_subnets" {
  description = "The IDs of private subnets"
  value       = aws_subnet.private_subnets[*].id
}

output "private_subnets" {
  description = "The IDs of public subnets"
  value       = aws_subnet.public_subnets[*].id
}

output "public_ip_bastion" {
  description = "The public IP of the bastion host"
  value       = aws_instance.bastion_host.public_ip
}

output "private_ec2_private_ip" {
  description = "The private IP of the private instances"
  value       = aws_instance.private_ec2_instance[*].private_ip
}

output "public_ec2_private_ip" {
  description = "The private IP of the public instances"
  value       = aws_instance.public_ec2_instance[*].private_ip
}
output "public_ec2_public_ip" {
  description = "The public IP of the public instances"
  value       = aws_instance.public_ec2_instance[*].public_ip
}
