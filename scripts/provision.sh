#!/usr/bin/env bash

id

# Install Docker CE 18.06 (as required by minikube)
curl -fsSL https://get.docker.com -o get-docker.sh
sudo VERSION=18.06 sh get-docker.sh

# Test Docker
docker run hello-world

# Install kubectl
sudo apt update && sudo apt install -y apt-transport-https
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
sudo apt update
sudo apt install -y kubectl

# Download and install minikube v.0.31.0
curl -Lo minikube https://storage.googleapis.com/minikube/releases/v0.31.0/minikube-linux-amd64 && chmod +x minikube && sudo cp minikube /usr/local/bin/ && rm minikube

# Check the sha256 checksum of minikube
echo "5926978aee75776af0867d112a77334b10ec65f687d734f238bfd88960c983c2 /usr/local/bin/minikube" | sha256sum -c -

sudo minikube start --vm-driver=none

kubectl version

apt-get -qq install unzip
wget https://releases.hashicorp.com/terraform/0.11.11/terraform_0.11.11_linux_amd64.zip
unzip terraform_0.11.11_linux_amd64.zip
rm -f terraform_0.11.11_linux_amd64.zip
mv terraform /usr/local/bin/

exit 0
