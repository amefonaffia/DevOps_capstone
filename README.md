# Capstone Project

To build a CI/CD pipeline for micro services applications with either blue/green deployment and develop Continuous Integration steps that include typographical checking (aka "linting").

This project shows skills of the following;
* Working in AWS
* Using Jenkins to implement Continuous Integration and Continuous Deployment
* Building pipelines
* Working with CloudFormation to deploy clusters
* Building Kubernetes clusters
* Building Docker containers in pipelines
* Blueocean on Jenkins

![alt text](https://github.com/amefonaffia/DevOps_capstone/blob/master/screenshots/pipelinescreenshot.JPG?raw=true)

---
## Static Website

Hosted site URL format is <**loadbalancer_domain:port**>

To collect information on loadbalancer domain:port, run `sudo kubectl describe service` on jenkins machine.

![alt text](https://github.com/amefonaffia/DevOps_capstone/blob/master/screenshots/tempsnip.png?raw=true)

---
## Error fixes

1. First visit [this medium page](https://medium.com/@andresaaap/jenkins-pipeline-for-blue-green-deployment-using-aws-eks-kubernetes-docker-7e5d6a401021) if you are running a blue green deployment to make sure you have configured all that is required.

2. For "**sudo: no tty present and no askpass program**" error, this is generally a permissions error when accessing jenkins machine, 
* Safe measure is to write certain commands that you would like to escape asking for password in Jenkinsfile with the `sudo -n` as opposed to `sudo`.

An otherwise unsafe method as it will not require password for ALL commands from the jenkins user,
* edit sudoers file `sudo nano /etc/sudoers` or gedit.
* add `jenkins ALL=(ALL) NOPASSWD: ALL` under the section *"# Allow members of group sudo to execute any command"*

3. For "**error: no context exists with the name:**". This is most likely because your jenkins user does not have permissions to access context files. I updated file [Jenkins machine file](infra_jenkins.sh) to switch to jenkins user earlier in kubectl configurations. However, for this error, on the jenkins machine;
* switch user to jenkins `sudo -su jenkins` (this is the user you are logged into from jenkins UI)
* run aws configure `aws configure`
* enable kubectl to run with jenkins user `sudo chmod u+x /kubectl/./kubectl` 
* then update kubeconfig `aws eks --region <region> update-kubeconfig --name <clustername>` 
* test that blueocean will be able to access context with the jenkins user `kubectl config use-context <context>`
* lastly, as an extra measure, add sudo to kubectl commands in Jenkinsfile.
