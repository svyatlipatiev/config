#!/bin/sh

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -

add-apt-repository "deb https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") $(lsb_release -cs) stable"

echo "deb http://apt.kubernetes.io kubernetes-xenial main" > /etc/apt/sources.list.d/kubernetes.list

apt-get update
apt-get install -y docker-ce kubelet kubeadm kubectl

kubeadm init --ignore-preflight-errors=all
mkdir -p /home/azureuser/.kube && rm -f /home/azureuser/.kube/config && sudo cp -rf -i /etc/kubernetes/admin.conf /home/azureuser/.kube/config && sudo chown azureuser:azureuser/.kube/config
sudo -u azureuser kubectl apply -f https://cloud.weave.works/k8s/net
kubeadm token create --print-join-command > /tmp/token.txt
