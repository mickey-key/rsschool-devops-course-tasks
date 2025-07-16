# RSSchool AWS DevOps 2025Q2 Task 4: Task 4: Jenkins Installation and Configuration


This repository contains jenkins configuration file for helm.

Task details can be found here https://github.com/rolling-scopes-school/tasks/blob/master/devops/modules/3_ci-configuration/task_4.md


## Prerequisities

minikube is installed. 
How to install minikube: https://minikube.sigs.k8s.io/docs/start/

## Project file structure


├── helm_jenkins

│   ├── jenkins_pvc.yaml - contains persistent volume claim for jenkins 

│   ├── jenkins_sa.yaml  - creates service account for jenkins

│   ├── jenkins_values_jcasc.yaml - values for Jenkins Configuration as Code

│   ├── jenkins_values.yaml - values for configuring Helm charts for Jenkins deployment on Kubernetes

│   └── jenkins_volume.yaml - to create Kubernetes persistent volume  named 'jenkins-pv'

├── README.md

└──.gitignore - specifies intentionally untracked files that Git should ignore


### Steps:
   

#### 1. Start cluster and create alias

```
minikube start
alias kubectl="minikube kubectl --"
```

#### 2. Install helm using package manager,  details here https://helm.sh/
```
sudo snap install helm --classic
```

Verify your Helm installation by deploying and removing the Nginx chart 

```
 helm install my-release oci://registry-1.docker.io/bitnamicharts/nginx
```

#### 3. Add jenking repo

```
helm repo add jenkinsci https://charts.jenkins.io
helm repo update
```
List helm chart in jenkins repo

```
helm search repo jenkinsci
```

#### 4. Create additional namespace 

```
kubectl create  namespace jenkins
```



#### 5. Create a persistent volume 
https://www.jenkins.io/doc/book/installing/kubernetes/#install-jenkins-with-helm-v3

``` 
minikube kubectl -- apply -f jenkins_volume.yaml 
```
create a persisctent volumeclaim 

https://kubernetes.io/docs/tasks/configure-pod-container/configure-persistent-volume-storage/


(configuration file can be found under jenkins directory in this repo)


#### 6. Install Jenkins
```
kubectl apply -f jenkins_sa.yaml 
chart=jenkinsci/jenkins
helm install jenkins -n jenkins -f jenkins_values.yaml $chart
```

Additional info: 

if pod does not start
```
kubectl logs jenkins-0 -c init -n jenkins
/var/jenkins_config/apply_config.sh: 4: cannot create /var/jenkins_home/jenkins.install.UpgradeWizard.state: Permission denied
disable Setup Wizard
```

it needs to change permissions for jenkins directory
```
minikube ssh
mkdir -p /var/lib/jenkins/jenkins-volume/
chown -R 1000:1000 /var/lib/jenkins/jenkins-volume/
```


If it is needed to access to jenkins inside, run
```
minikube kubectl -- exec --namespace jenkins -it svc/jenkins -c jenkins -- /bin/bash
```

#### 7. Update helm chart values to create job using JCasC

the job is already added to the file `jenkins_values_jcasc.yaml`. 

run helm update to apply changes
```
helm upgrade jenkins -n jenkins -f jenkins_values_jcasc.yaml $chart

```


