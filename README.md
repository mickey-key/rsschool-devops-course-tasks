# RSSchool AWS DevOps 2025Q2 Task 6:  Application Deployment via Jenkins Pipeline

This repository contains the configuration files for simple flask application deployment.
Task details can be found here https://github.com/rolling-scopes-school/tasks/blob/master/devops/modules/3_ci-configuration/task_6.md



## Prerequisities

- jenkins is installed with kubernetes, docker, git plugins

- Kubernetes cluster is installed and configured. 

- docker registry account is created 


## Project file structure

├── flask_app   - diresctory with application configuration files 

│   ├── Dockerfile - contains instructions for building the source code

│   ├── main.py - python source code of the application

│   └── requirements.txt - requirements for running the application 

├── helm

│   ├── Chart.yaml -  contains a description of the chart, metadata of helm chart 

│   ├── templates -  directory for template files

│   │   ├── deployment.yaml - defines the Kubernetes Deployment for the application 

│   │   └── service.yaml - a basic manifest for creating a service endpoint for the deployment

│   └── values.yaml -  contains the default values for the chart

├── README.MD - information about installation

├── Jenkinsfile - Jenkins pipeline text file with deployment steps

### Steps:

## configure jenkins job

- add new pipeline on Jenkins and set gitHub project as current project
- configure PollSCM with the schedule 
'''
H/5 * * * *
'''
- choose pipeline script from SCM
  - SCM -> Git
  - Repository URL -> set current repository address
  - specify branch as "*/task_6"
  
## additional Jenkins configuration

- configure the credentials for docker registry with ID 'dockerhub'

## run the job

manually build or it will be triggered by any new commit to repository 

## checks

the result of pipeline execution with be emailed to the email address pre-configured in Jenkinsfile 




