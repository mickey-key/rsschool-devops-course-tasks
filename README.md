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


## Prerequisities

- AWS account and aws cli configured
- Terraform installed 
- on AWS: create EC2 key pair on AWS with the name "key" by default (or modify variable.tf for your value)
- configure key pair for ssh connection and set env variable TF_VAR_private_key_pem



## Project file structure

terraform/

├── bastion.tf -  creates an EC2 Bastion Host in public subnet

├── ec2-instances.tf - EC 2 instances in private and public subnets

├── internet-gateway.tf - creates Internet gateway so that instances can have internet access

├── main.tf - configuration aws terraform provider and s3 bucket for state file

├── network-acl.tf - defines networks ACL with rules to control inbound and outbound traffic for a VPC

├── outputs.tf - to return values of created configuration (IPs of instances, ID for subnets and VPC for quicker reference)

├── providers.tf - defines the provider, sets the main region to deploy resources

├── security-groups.tf - creates Security Groups for using with EC2 instances 

├── subnets.tf - creates public and private subnets for VPC

├── variables.tf - defines variables

└── vpc.tf - defines VPC parameters

└──.github/workflows/terraform.yml - Github Action workflow 

└──.gitignore - specifies intentionally untracked files that Git should ignore


### Steps:


#### 1. Check that terraform is installed

```
terraform -v
```

#### 2. Clone the repository. Change working directory to 'terraform' and initialize a Terraform working directory

```
cd rsschool-devops-course-tasks/terraform
terraform init
```
#### 3. Create an execution plan, which lets you preview the changes that Terraform plans to make to your infrastructure

```
terraform plan
```

#### 4. Applying the changes to the infrastructure

```
terraform apply
```

#### The GitHub Actions workflow: 


file .github/workflows/terraform.yml - to use with Github Actions to automate deployment on push or pull_request to the main brunch
  
```
terraform-check: checks the format of Terraform configuration files
```
```
terraform-plan: Initializes Terraform and creates an execution plan
```     
```
 terraform-apply: [on push to main] applies the changes and provision configuration to AWS 
```

