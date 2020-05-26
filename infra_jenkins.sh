#!/bin/bash
sudo apt-get update && sudo apt-get -y upgrade
sudo apt-get -y install default-jdk
wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 9B7D32F2D50582E6
sudo apt-get update && sudo apt-get -y install jenkins && sudo systemctl start jenkins && sudo systemctl enable jenkins
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
sudo apt install ansible && sudo pip install boto
sudo apt update && sudo apt -y install docker.io && sudo systemctl start docker && sudo systemctl enable docker && sudo apt update && sudo apt -y install tidy && sudo chmod 666 /var/run/docker.sock
apt-get update && apt-get install unzip awscli -y
apt-get install apache2 -y
sudo su -jenkins
aws configure --region us-east-2
curl -o kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.16.8/2020-04-16/bin/linux/amd64/kubectl &&
chmod +x ./kubectl && mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$PATH:$HOME/bin
echo 'export PATH=$PATH:$HOME/bin' >> ~/.bashrc
kubectl version --short --client
sudo chmod u+x /kubectl/./kubectl
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin
eksctl version
eksctl create cluster --name amycapstonecluster --version 1.16 --nodegroup-name standard-workers --node-type t2.micro --nodes 2 --nodes-min 1 --nodes-max 3 --node-ami auto --region us-east-2 --zones us-east-2a --zones us-east-2b --zones us-east-2c
kubectl get svc
aws eks --region us-east-2 update-kubeconfig --name capstonecluster
