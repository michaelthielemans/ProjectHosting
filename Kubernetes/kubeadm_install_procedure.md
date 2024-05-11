#VERY important! Be aware of the version matrix of all the different components
K8s 1.29 - compatible with - cilium 1.15.4
K8s 1.30 - not yet compatible with - cilium

# Installing kubernetes with kubeadm on UBUNTU
-------------------------
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

## Installing containerd
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


## download and extract containerd   
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
```
sudo mkdir /etc/containerd
sudo touch /etc/containerd/config.toml
sudo chmod 777 /etc/containerd/config.toml
containerd config default > /etc/containerd/config.toml
```
The systemd cgroup driver is recommended if you use cgroup v2.
--> rocky9 and ubuntu uses cgroup2fs
the cgroup you use can be checked with   $ stat -fc %T /sys/fs/cgroup/

The default configuration can be generated via (run as root)
containerd config default

Open the config.toml and adjust the settings
```
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
$ sudo systemctl restart containerd
```
## install CNI plugins
```
cd /opt
sudo wget https://github.com/containernetworking/plugins/releases/download/v1.4.1/cni-plugins-linux-amd64-v1.4.1.tgz
sudo mkdir -p /opt/cni/bin
sudo chown root:root cni/bin
sudo tar Cxzvf /opt/cni/bin cni-plugins-linux-amd64-v1.4.1.tgz
```
❗ Check the permissions on the bin folder inside the cni directory! should be root:root 755 ❗
## manually configure the cgroup driver for kubelet.
    Kubeadm will use the systemd cgroup driver, from
    this is not needed when using kubeadm version higher then 1.28

## install kubeadm, kubectl, kubelet packages on ubuntu
``` sudo apt-get update
# apt-transport-https may be a dummy package; if so, you can skip that package
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

# create the cluster
## check if network route is ok
```
$ ip route show # Look for a line starting with "default via"
```
## Initializing your control-plane node
```
sudo kubeadm init --apiserver-advertise-address=172.24.1.81 --pod-network-cidr=10.244.0.0/16
```
If you want to configure in HA you need to add the --control-plane-endpoint= parameter !
You can skip specific addons by --skip-
Installed by default:
[addons] Applied essential addon: CoreDNS
[addons] Applied essential addon: kube-proxy

if you have a iptables error:
```
sudo modprobe br_netfilter
```

# Make kubectl available for users:
first check the config in /etc/kubernetes/admin.conf file -> check if it point to the correct network port !! 6443
```
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
```

## export the KUBECONFIG alias if you are the root user
```
$ export KUBECONFIG=/etc/kubernetes/admin.conf
```



# deploying the cilium pod network
## Install the Cilium CLI
Installing cilium cni, hubble, ... can be done with cilium cli
```
CILIUM_CLI_VERSION=$(curl -s https://raw.githubusercontent.com/cilium/cilium-cli/main/stable.txt)
CLI_ARCH=amd64
if [ "$(uname -m)" = "aarch64" ]; then CLI_ARCH=arm64; fi
curl -L --fail --remote-name-all https://github.com/cilium/cilium-cli/releases/download/${CILIUM_CLI_VERSION}/cilium-linux-${CLI_ARCH}.tar.gz{,.sha256sum}
sha256sum --check cilium-linux-${CLI_ARCH}.tar.gz.sha256sum
sudo tar xzvfC cilium-linux-${CLI_ARCH}.tar.gz /usr/local/bin
rm cilium-linux-${CLI_ARCH}.tar.gz{,.sha256sum}
```

Check if cilium cli is installed:
the latest version of the cilium cli can be found at https://github.com/cilium/cilium-cli/releases
```
cilium version --client
```

## install cilium from the CLI
```
cilium install --version 1.15.4
```
check the installation
```
cilium status --wait
cilium connectivity test --single-node
cilium connectivity test
```

## adjust the ownership of the /opt/cni/bin directory
during installation, cilium will create a couple of pods. the cilium-xxxx pods will pull some data from the /opt/cni/bin folder. by default this folder is not owned by root, change it to root
```
sudo chown root:root /opt/cni/bin
```


### install helm
            $ curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
            $ chmod 700 get_helm.sh
            $ ./get_helm.sh

add the cilium helm repo and install cilium
```
helm repo add cilium https://helm.cilium.io/
```
```
helm install cilium cilium/cilium --version 1.15.4 --namespace kube-system
```
check if cilium is successfully installed
```
kubectl -n kube-system get pods --watch
```


# adding nodes to the cluster
```
kubeadm join 172.24.1.81:6443 --token xxxxx --discovery-token-ca-cert-hash sha256:
```
if you cannot find the token you can list it
```
$ kubeadm token list
```
REBOOT

# Troubleshooting

kubeadm checks
```$ kubeadm cluster-info
kubectl get nodes
kubeclt checks
```

containerd checks
$ ctr











WARNING: Kubernetes configuration file is group-readable. This is insecure. Location: /etc/kubernetes/admin.conf
WARNING: Kubernetes configuration file is world-readable. This is insecure. Location: /etc/kubernetes/admin.conf
W0504 19:18:49.552081    4240 warnings.go:70] spec.template.metadata.annotations[container.apparmor.security.beta.kubernetes.io/mount-cgroup]: deprecated since v1.30; use the "appArmorProfile" field instead
W0504 19:18:49.552112    4240 warnings.go:70] spec.template.metadata.annotations[container.apparmor.security.beta.kubernetes.io/apply-sysctl-overwrites]: deprecated since v1.30; use the "appArmorProfile" field instead
W0504 19:18:49.552124    4240 warnings.go:70] spec.template.metadata.annotations[container.apparmor.security.beta.kubernetes.io/clean-cilium-state]: deprecated since v1.30; use the "appArmorProfile" field instead
W0504 19:18:49.552133    4240 warnings.go:70] spec.template.metadata.annotations[container.apparmor.security.beta.kubernetes.io/cilium-agent]: deprecated since v1.30; use the "appArmorProfile" field instead
NAME: cilium
LAST DEPLOYED: Sat May  4 19:18:47 2024
NAMESPACE: kube-system
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
You have successfully installed Cilium with Hubble.

Your release version is 1.15.4.

For any further help, visit https://docs.cilium.io/en/v1.15/gettinghelp
