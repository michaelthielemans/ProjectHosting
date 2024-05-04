# Installing kubernetes with kubeadm on UBUNTU
-------------------------
- Set static ip address
- Set the hostname correct
- Edit the hosts file
  - add all other ip's and hostnames of the other nodes in the cluster
## disable swap
    swapoff -a
    /etc/fstab

## allow port to ufw
```
$ sudo ufw allow 6443
$ sudo ufw reload
```
## check if the product_uuid is unique on every node
```
$ sudo cat /sys/class/dmi/id/product_uuid
```
## check if the mac addresses are unique on every node
```
ip link
ip a
```

Reboot the machine

## Installing containerd
### Enable IPv4 packet forwarding
sysctl params required by setup, params persist across reboots
```
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.ipv4.ip_forward = 1
EOF
```
Apply sysctl params without reboot
```
$ sudo sysctl --system
```
### Verify that net.ipv4.ip_forward is set to 1 with:
```
$ sysctl net.ipv4.ip_forward
```
## download and extract containerd   
### download and extract from official binaries
in dir /usr/local
```
wget https://github.com/containerd/containerd/releases/download/v1.7.15/containerd-1.7.15-linux-amd64.tar.gz
tar Cxzvf /usr/local containerd-1.7.15-linux-amd64.tar.gz
```
### enable start containerd with systemd
```
cd /usr/lib/systemd/system/
wget https://raw.githubusercontent.com/containerd/containerd/main/containerd.service

systemctl daemon-reload
systemctl enable --now containerd
```

### install runc
```
cd /usr/local
wget https://github.com/opencontainers/runc/releases/download/v1.1.12/runc.amd64
install -m 755 runc.amd64 /usr/local/sbin/runc
```
### adjustment of the config.toml file for systemd
```
mkdir /etc/containerd
touch /etc/containerd/config.toml

            The systemd cgroup driver is recommended if you use cgroup v2.
        --> rocky9 and ubuntu uses cgroup2fs
            the cgroup you use can be checked with   $ stat -fc %T /sys/fs/cgroup/

        The default configuration can be generated via (run as root)
        ` containerd config default > /etc/containerd/config.toml

        Open the config.toml and adjust the settings

        [plugins."io.containerd.grpc.v1.cri".containerd.runtimes.runc]
        ...
            [plugins."io.containerd.grpc.v1.cri".containerd.runtimes.runc.options]
                SystemdCgroup = true
```
### adjust config file for sandbox image that is compatible wit the kubetrnetes version
        [plugins."io.containerd.grpc.v1.cri"]
            sandbox_image = "registry.k8s.io/pause:3.9"

### restart container d
```
$ systemctl restart containerd
```
## install CNI plugins
```
in dir /opt
wget https://github.com/containernetworking/plugins/releases/download/v1.4.1/cni-plugins-linux-amd64-v1.4.1.tgz
mkdir -p /opt/cni/bin
tar Cxzvf /opt/cni/bin cni-plugins-linux-amd64-v1.4.1.tgz
```

## manually configure the cgroup driver for kubelet.
    Kubeadm will use the systemd cgroup driver, from
    this is not needed when using kubeadm version higher then 1.28

## install kubeadm, kubectl, kubelet packages on ubuntu
``` sudo apt-get update
# apt-transport-https may be a dummy package; if so, you can skip that package
sudo apt-get install -y apt-transport-https ca-certificates curl gpg
```

## If the directory `/etc/apt/keyrings` does not exist, it should be created before the curl command, read the note below.
```
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.30/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
```
## add package repository for kubernetes 1.30
```
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.30/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
```

## install packages
```
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl
```

### Enable the kubelet service before running kubeadm
` sudo systemctl enable --now kubelet

# create a cluster
## check if network route is ok
```
$ ip route show # Look for a line starting with "default via"
```
## Initializing your control-plane node
```
$ kubeadm init --apiserver-advertise-address=172.24.1.81 --pod-network-cidr
```
## export the KUBECONFIG alias if you are the root user
```
$ export KUBECONFIG=/etc/kubernetes/admin.conf
```

# deploying the cilium pod network
    ## Install the Cilium CLI with helm

        ### install helm
            $ curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
            $ chmod 700 get_helm.sh
            $ ./get_helm.sh

        ### add the cilium helm repo
            helm repo add cilium https://helm.cilium.io/

        ###
            helm install cilium cilium/cilium --version 1.15.4 \
            --namespace kube-system


# adding nodes to the cluster

kubeadm join 192.168.10.39:6443 --token abcdef.0123456789abcdef \
        --discovery-token-ca-cert-hash sha256:6847cfd8e88a3c3422b95db8c0b0f7024f87a1f28b913d8e775240f485f8b0b1

    ## if you cannot find the token you can list it
        $ kubeadm token list



# Troubleshooting

kubeadm checks
$ kubeadm cluster-info

kubeclt checks


containerd checks
$ ctr
