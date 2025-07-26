variable "regions" {
  type        = string
  default     = "eu-west-1"
  description = "defines the needed region"
}

variable "vpc_cidr_block" {
  type        = string
  default     = "10.0.0.0/16"
  description = "IPv4 CIDR block"
}

variable "public_subnets_cidr" {
  type        = list(string)
  default     = ["10.0.3.0/24"]
  description = "IPv4 subnet CIDR block for public subnets"
}

variable "availability_zones" {
  type        = list(string)
  default     = ["eu-west-1a"]
  description = "Availability Zones for subnets"
}

variable "instance_ami" {
  type        = string
 # default     = "ami-015b1e8e2a6899bdb" #amazon linux
   default     = "ami-01f23391a59163da9" #ubuntu
  
  description = "AMI"
}

variable "instance_type" {
  type        = string
  default     = "t2.small"
  description = "Type for ec2 instances"
}

variable "ssh_keyname" {
  type        = string
  default     = "key"
  description = "key name for storing your ssh keys"
}

variable "private_key_pem" {
  type      = string
  sensitive = true
}

