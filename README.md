# RSSchool AWS DevOps 2025Q2 Task 2: Basic Infrastructure Configuration

This repository contains Terraform configuration and GitHub Actions workflow for Task 2.
Task details can be found here https://github.com/rolling-scopes-school/tasks/blob/master/devops/modules/1_basic-configuration/task_2.md

## Infrastructure Overview
    VPC
    2 public subnets in different availability zones
    2 private subnets in different availability zones
    An Internet Gateway for internet access
    A Bastion host for secure access to instances in the private subnets
    A NAT Gateway for internet access for private instances
    Security groups and network ACLs for the VPC and subnets
    EC2 instances in private and public subnets


##Prerequisities

- AWS account and aws cli configured
- terraform installed 
- configure key pair for ssh connection
 create EC2 key pair on AWS with the name "key" by defailt (or modify variable.tf for your value)
 export TF_VAR_private_key_pem="-----BEGIN RSA PRIVATE KEY-----...----END RSA PRIVATE KEY-----"


## Project file structure
terraform/
├── bastion.tf -  creates an EC2 Bastion Host in public subnet
├── ec2-instances.tf - EC 2 instances in private and public subnets
├── internet-gateway.tf - creates Internet gateway so that instances can have internet access
├── main.tf - configuration aws terraform provider and s3 bucket for state file
├── network-acl.tf - defines networks ACL with rules to control inbound and outbound traffic for a VPC
├── outputs.tf - to return values of created configuration (IPs of instances, ID for submets and VPC for quicker refferebce )
├── providers.tf - defines the provider, sets the main region to deploy resources
├── security-groups.tf - creates Security Groups for using with EC2 instances 
├── subnets.tf - creates public and private subnets for VPC
├── variables.tf - defines variables
└── vpc.tf - defines VPC parameters

└──.github/workflows/terraform.yml - Github Action workflow 

└──.gitignore - specifies intentionally untracked files that Git should ignore


### Steps:


#  1. Check the terraform is installed

```terraform -v
```

# 2. clone repository. Change working directory to 'terraform' and initialize a Terraform working directory

```
cd rsschool-devops-course-tasks/terraform
terraform init
```
# 3. Creating an execution plan, which lets you preview the changes that Terraform plans to make to your infrastructure

```terraform plan
```

# 4. Applying the changes to infrastructure

```terraform apply
```

## The GitHub Actions workflow: 
to use with Github Actions to automate deployment on push or pull_request to main 
file .github/workflows/terraform.yml
    terraform-check: checks the format of terraform configuration files
    terraform-plan: initializes terraform and creates an execution plan
    terraform-apply: [on push to main] applies the changes and provision configuration to AWS 

