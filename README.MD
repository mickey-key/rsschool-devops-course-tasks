# RSSchool AWS DevOps 2025Q2 Task 5: Simple Application Deployment with Helm

This repository contains the configfuration files for deployment a flask application on kubernetes cluster using helm.
Task details can be found here https://github.com/rolling-scopes-school/tasks/blob/master/devops/modules/3_ci-configuration/task_5.md



## Prerequisities

- Kubernetes cluster is installed and configured. For local deployment configuring minikube will be enough 
How to install minicube: https://minikube.sigs.k8s.io/docs/start/

- Helm is installed (how to install: https://helm.sh/)

- docker repository is configured to store images

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


### Steps:

## build and public docker image

clone the current repository

```
    cd flask-app
    docker build -t mickey/hello-flask-app:1.0 .
    docker tag mickey/hello-flask-app:1.0 mickeykey/hello-flask-app:latest
    docker push mickeykey/hello-flask-app:latest
```

optional: it can be tested by 

```
docker run -d -p 8888:8080 mickey/hello-flask-app:1.0
```

## install helm chart
(create a new namespace beforehead)

```
minikube kubectl -- create namespace flask
helm install my-hello-app ./helm 
```

create a port forward to make it accessible on local VM

```
minikube kubectl -- --namespace flask port-forward svc/hello-flask-app 8080:8080
```
## checks 

Check the pod is running

```
  minikube kubectl -- get deployment
  minikube kubectl -- --namespace flask get pods
```

Check the application is accessible on 
http://localhost:8080/ 

