#! /usr/bin/bash

sudo ufw allow 6443
sudo ufw reload

sudo apt update -y
sudo apt install -y nfs-common

sudo cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.ipv4.ip_forward = 1
EOF

sudo sysctl --system

sudo modprobe br_netfilter

cd /usr/local
sudo wget https://github.com/containerd/containerd/releases/download/v1.7.15/containerd-1.7.15-linux-amd64.tar.gz
sudo tar Cxzvf /usr/local containerd-1.7.15-linux-amd64.tar.gz

cd /usr/lib/systemd/system/
sudo wget https://raw.githubusercontent.com/containerd/containerd/main/containerd.service
sudo systemctl daemon-reload
sudo systemctl enable --now containerd

cd /usr/local
sudo wget https://github.com/opencontainers/runc/releases/download/v1.1.12/runc.amd64
sudo install -m 755 runc.amd64 /usr/local/sbin/runc

sudo mkdir /etc/containerd
sudo touch /etc/containerd/config.toml
sudo chmod 777 /etc/containerd/config.toml
containerd config default > /etc/containerd/config.toml

echo "adjust the config.toml and adjust the settings so it will use systemc as cgroup driver.

        [plugins."io.containerd.grpc.v1.cri".containerd.runtimes.runc]
        ...
            [plugins."io.containerd.grpc.v1.cri".containerd.runtimes.runc.options]
                SystemdCgroup = true"


sudo systemctl restart containerd

cd /opt
sudo wget https://github.com/containernetworking/plugins/releases/download/v1.4.1/cni-plugins-linux-amd64-v1.4.1.tgz
sudo mkdir -p /opt/cni/bin
sudo chown root:root cni/bin
sudo tar Cxzvf /opt/cni/bin cni-plugins-linux-amd64-v1.4.1.tgz

sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl gpg

sudo curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.29/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.29/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list

sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl

sudo systemctl enable --now kubelet
