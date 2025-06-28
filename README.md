# RSSchool AWS DevOps 2025Q2 Task 3: Task: K8s Cluster Configuration and Creation

This repository contains Terraform configuration and GitHub Actions workflow for Task 3.
Task details can be found here https://github.com/rolling-scopes-school/tasks/blob/master/devops/modules/2_cluster-configuration/task_3.md

## Infrastructure Overview
    VPC
    2 public subnets in different availability zones
    2 private subnets in different availability zones
    An Internet Gateway for internet access
    A Bastion host for secure access to instances in the private subnets
    A NAT Gateway for internet access for private instances
    Security groups and network ACLs for the VPC and subnets
    EC2 instances in private and public subnets
    Kubernetes k3s master and agent nodes are running on EC2 instances in private subnet
    Access from bastion host 

## Prerequisities

- AWS account and aws cli configured
- terraform installed 
- on AWS: create EC2 key pair on AWS with the name "key" by defailt (or modify variable.tf for your value)
- configure key pair for ssh connection and set env variable TF_VAR_private_key_pem
- define token for k3s cluster TF_VAR_token_k3s="<token_value>"


## Project file structure

terraform/

├── bastion.tf -  creates an EC2 Bastion Host in public subnet

├── ec2-instances.tf - EC 2 instances in private and public subnets with k3s installed on start

├── internet-gateway.tf - creates Internet gateway so that instances can have internet access, defines NAT gateway for private subnet instances access

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

### Crate infrastructure using terraform

#### 1. Check the terraform is installed

```
terraform -v
```

#### 2. Clone repository. Change working directory to 'terraform' and initialize a Terraform working directory

```
cd rsschool-devops-course-tasks/terraform
terraform init
```
#### 3. Create an execution plan, which lets you preview the changes that Terraform plans to make to your infrastructure

```
terraform plan
```

#### 4. Applying the changes to infrastructure

```
terraform apply
```

### Access to k3s cluster and additional configuration 
#### 1. Configure access from bastion

k3s cluster  will be deployed on two different private EC2 instances (in private subnets)
- Master (control-plane) node
- Agent node


1. connect to bastion via ssh
2. install kubernetes (https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/)
3. copy /etc/rancher/k3s/k3s.yaml from EC" where k3s master node to bastion 
4. on bastion run
```
export KUBECONFIG=<config.yaml>
```
5. check
```
kubectl get nodes
```
run nginx by
```
kubectl apply -f https://k8s.io/examples/pods/simple-pod.yaml
```

#### 2. Configure access to kubernetes cluster from local computer
copy  config yaml filre from bastion to your local computer
changes IP of node to localhost in config file
create port forward by
```
 ssh  -L 6443:<IP master>:6443 ec2-user@<IP bastion>  -i <key>
 ```
check 
```
kubectl get nodes
```



#### The GitHub Actions workflow: 

file .github/workflows/terraform.yml - to use with Github Actions to automate deployment on push or pull_request to the main brunch
  
```
terraform-check: checks the format of terraform configuration files
```
```
terraform-plan: initializes terraform and creates an execution plan
```     
```
 terraform-apply: [on push to main] applies the changes and provision configuration to AWS 
```


