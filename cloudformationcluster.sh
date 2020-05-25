#!/bin/bash
sudo apt update && sudo apt -y install docker.io && sudo systemctl start docker && sudo systemctl enable docker && sudo apt update && sudo apt -y install tidy && sudo chmod 666 /var/run/docker.sock
apt-get update && apt-get install unzip awscli -y
apt-get install apache2 -y
curl -o kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.16.8/2020-04-16/bin/linux/amd64/kubectl &&
chmod +x ./kubectl && mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$PATH:$HOME/bin
echo 'export PATH=$PATH:$HOME/bin' >> ~/.bashrc
kubectl version --short --client
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin
eksctl version
eksctl create cluster --name amycapstonecluster --version 1.16 --nodegroup-name standard-workers --node-type t2.micro --nodes 2 --nodes-min 1 --nodes-max 3 --node-ami auto --region us-east-2 --zones us-east-2a --zones us-east-2b --zones us-east-2c
kubectl get svc