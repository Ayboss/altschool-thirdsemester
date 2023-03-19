#!/bin/bash 
# install terraform , install kubctl
sudo apt-get update 
sudo apt-get install -y gnupg software-properties-common

wget -O- https://apt.releases.hashicorp.com/gpg | \
gpg --dearmor | \
sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg

gpg --no-default-keyring \
--keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
--fingerprint

echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update
sudo apt-get install terraform

curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl


# install helm, helm repo add and the likes
curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null
sudo apt-get install apt-transport-https --yes
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
sudo apt-get update
sudo apt-get install helm

# CREATING CLUSTER AND RUNNING KUBERNETES CREATE
read -p 'Input your Linode token: ' token
export TF_VAR_token=$token
# running terraform 
terraform init 
terraform apply -auto-approve 
export KUBE_VAR=`terraform output --raw kubeconfig` && echo $KUBE_VAR | base64 -d -i > lke-cluster-config.yaml
export KUBECONFIG=lke-cluster-config.yaml
# run the 
kubectl create -f complete-demo.yaml


helm repo add prometheus-community https://prometheus-community.github.io/helm-charts

helm repo update

# should already have kubernetes cluster here
helm install prometheus prometheus-community/prometheus
# it includes prometheus into pods 
# expose prometheus by giving it a service of nodeport
kubectl expose service prometheus-server --type=LoadBalancer --target-port=9090 --name=prometheus-server-ext

$(sleep 100)
kubectl get service front-end -n sock-shop
kubectl get service prometheus-server-ext