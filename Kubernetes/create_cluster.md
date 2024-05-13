

# Create or join a Kubernetes cluster
-----------

## check if network route is ok
```
$ ip route show # Look for a line starting with "default via"
```
## Initializing your control-plane node
```
sudo kubeadm init --apiserver-advertise-address=172.24.1.81 --skip-phases=addon/kube-proxy
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

## Set the correct config file file the root user / sudo
create a password for the root user, so you can login as root
```
sudo passwd root
```
switch to root user and copy the config file to the correct directory (/root/.kube/config)
```
su root
mkdir /root/.kube
cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
```
optional: export the KUBECONFIG alias if you are the root user
```
$ export KUBECONFIG=/etc/kubernetes/admin.conf
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


# enable hubble cilium
```
cilium hubble enable -ui
```
## Install the Hubble Client cli tool on a client pc
```
HUBBLE_VERSION=$(curl -s https://raw.githubusercontent.com/cilium/hubble/master/stable.txt)
HUBBLE_ARCH=amd64
if [ "$(uname -m)" = "aarch64" ]; then HUBBLE_ARCH=arm64; fi
curl -L --fail --remote-name-all https://github.com/cilium/hubble/releases/download/$HUBBLE_VERSION/hubble-linux-${HUBBLE_ARCH}.tar.gz{,.sha256sum}
sha256sum --check hubble-linux-${HUBBLE_ARCH}.tar.gz.sha256sum
sudo tar xzvfC hubble-linux-${HUBBLE_ARCH}.tar.gz /usr/local/bin
rm hubble-linux-${HUBBLE_ARCH}.tar.gz{,.sha256sum}
```


# Troubleshooting

kubeadm checks
```$ kubeadm cluster-info
kubectl get nodes
kubeclt checks
```

containerd checks
$ ctr
