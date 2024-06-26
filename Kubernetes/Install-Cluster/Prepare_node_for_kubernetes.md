#Kubernetes 
# How-To for preparing a node (master or worker) before creating or joining a cluster
----------
| Navigation |
|-----|
| [[#Considerations before starting the installation]] | 
| [[#Preparations]] |
| [[#Packet forwarding]] |
| [[#Download and extract containerd]] |
| [[#Install CNI plugins]] |
| [[#Install kubeadm, kubectl, kubelet packages on ubuntu]] |

## Considerations before starting the installation

#### VERY important! Be aware of the version matrix of all the different components
K8s 1.29 - compatible with - cilium 1.15.4
K8s 1.30 - not yet compatible with - cilium
Also double check the version compatibility between other components like the containerd CRI.
### Virtual machine provisioning
- cpu : can always be changed later on if needed (needs a reboot)
	- masternode: 4 cores is sufficient
	- workernode: 4 cores or more depending on the workload
- memory:  can always be changed later on if needed (needs a reboot)
	- masternode: min 4 Gig 
	- workernode: min 4 gig
- Storage: Provision enough storage beforehand, expanding volumes can be cumbersome.
	- Masternode: 50 Gig for /root partition
	- Workernode: 250 Gig depending on the amount of images that will be used on the cluster. When 
	> Think about using LVM managed volumes to install you OS on, this will enable you to enlarge volumes easily later on.
	> Containerd will store images in /var/lib/containerd/  -> this can be changed in the toml file /etc/containerd/config.toml  
	> [check official documentation](https://kubernetes.io/blog/2024/01/23/kubernetes-separate-image-filesystem/#:~:text=This%20can%20be%20located%20as,%2Fvar%2Flib%2Fcontainerd%20.)
## Preparations

- Set static ip address
- Set the hostname correct
- Edit the hosts file
  - add all other ip's and hostnames of the other nodes in the cluster
### disable swap
    swapoff -a
    /etc/fstab

### allow port to ufw
```
sudo ufw allow 6443
sudo ufw reload
```
### check if the product_uuid is unique on every node
```
sudo cat /sys/class/dmi/id/product_uuid
```
### check if the mac addresses are unique on every node
```
ip link
ip a
```

### Install nfs-common package on the workernodes
this package will make it possible for the persistent volume to be created on the node.
```
sudo apt install nfs-common
```

### Reboot the machine

## Packet forwarding
### Enable IPv4 packet forwarding
sysctl params required by setup, params persist across reboots
```
sudo cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.ipv4.ip_forward = 1
EOF
```
Apply sysctl params without reboot
```
sudo sysctl --system
```

### Verify that net.ipv4.ip_forward is set to 1 with:
```
sudo sysctl net.ipv4.ip_forward
```

### On debian based systems
```
sudo modprobe br_netfilter
```


## Download and extract containerd   
### download and extract from official binaries
in dir /usr/local
```
cd /usr/local
sudo wget https://github.com/containerd/containerd/releases/download/v1.7.15/containerd-1.7.15-linux-amd64.tar.gz
sudo tar Cxzvf /usr/local containerd-1.7.15-linux-amd64.tar.gz
```
### enable start containerd with systemd
```
cd /usr/lib/systemd/system/
sudo wget https://raw.githubusercontent.com/containerd/containerd/main/containerd.service
sudo systemctl daemon-reload
sudo systemctl enable --now containerd
```

### install runc
```
cd /usr/local
sudo wget https://github.com/opencontainers/runc/releases/download/v1.1.12/runc.amd64
sudo install -m 755 runc.amd64 /usr/local/sbin/runc
```
### adjustment of the config.toml file for systemd

#### Set generate the config file , set permissions
```
sudo mkdir /etc/containerd
sudo touch /etc/containerd/config.toml
sudo chmod 777 /etc/containerd/config.toml
containerd config default > /etc/containerd/config.toml
```
The last command will generate the default settings and piped into the config.toml file

The systemd cgroup driver is recommended if you use cgroup v2.
--> rocky9 and ubuntu uses cgroup2fs
the cgroup you use can be checked with   $ stat -fc %T /sys/fs/cgroup/


#### adjust the config.toml and adjust the settings so it will use systemc as cgroup driver.
```
        [plugins."io.containerd.grpc.v1.cri".containerd.runtimes.runc]
        ...
            [plugins."io.containerd.grpc.v1.cri".containerd.runtimes.runc.options]
                SystemdCgroup = true
```
### If you user another version of kubernetes (not 1.29) check which sandbox image you need to use.
Adjust /etc/containerd/config.toml config file for sandbox image that is compatible wit the kubetrnetes version
```
        [plugins."io.containerd.grpc.v1.cri"]
            sandbox_image = "registry.k8s.io/pause:3.9"
```
### restart container d
```
sudo systemctl restart containerd
```
## Install CNI plugins
```
cd /opt
sudo wget https://github.com/containernetworking/plugins/releases/download/v1.4.1/cni-plugins-linux-amd64-v1.4.1.tgz
sudo mkdir -p /opt/cni/bin
sudo chown root:root cni/bin
sudo tar Cxzvf /opt/cni/bin cni-plugins-linux-amd64-v1.4.1.tgz
```
❗ Check the permissions on the bin folder inside the cni directory! should be root:root 755 ❗
Do this on every node !!! Solve it it by :
```
cd /opt/cni
sudo chown -R root:root bin
```

## (optionally) manually configure the cgroup driver for kubelet.
    Kubeadm will use the systemd cgroup driver, from
    this is not needed when using kubeadm version higher then 1.28

## Install kubeadm, kubectl, kubelet packages on ubuntu
```
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl gpg
```

### If the directory `/etc/apt/keyrings` does not exist, it should be created before the curl command.

if you want to use version v1.30
```
sudo curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.30/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
```

if you want to use v1.29
```
sudo curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.29/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
```


if you want to use 1.30 add package repository for kubernetes 1.30
```
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.30/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
```
v1.29
```
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.29/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
```

### install packages
```
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl
```

### Enable the kubelet service before running kubeadm
```
sudo systemctl enable --now kubelet
```
The kubelet is now restarting every few seconds, as it waits in a crashloop for kubeadm to tell it what to do.
