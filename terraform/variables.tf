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

variable "privat_subnets_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
  description = "IPv4 subnet CIDR block for privat subnets"
}

variable "public_subnets_cidr" {
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
  description = "IPv4 subnet CIDR block for public subnets"
}

variable "availability_zones" {
  type        = list(string)
  default     = ["eu-west-1a", "eu-west-1b"]
  description = "Availability Zones for subnets"
}

variable "instance_ami" {
  type        = string
  default     = "ami-015b1e8e2a6899bdb"
  description = "Amazon Linux 2023 - Free tier by default"
}



variable "instance_type" {
  type        = string
  default     = "t2.micro"
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
