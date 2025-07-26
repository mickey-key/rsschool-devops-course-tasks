output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.rs_course_vpc.id
}

output "public_subnets" {
  description = "The IDs of private subnets"
  value       = aws_subnet.public_subnets[*].id
}


output "public_ec2_instance_b_private_ip" {
  description = "The private IP of the public instances"
  value       = aws_instance.public_ec2_instance.private_ip
}
output "public_ec2_instance_b_public_ip" {
  description = "The public IP of the public instances"
  value       = aws_instance.public_ec2_instance.public_ip
}