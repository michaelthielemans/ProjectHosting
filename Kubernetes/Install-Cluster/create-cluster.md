#kubernetes 
# Create or join a Kubernetes cluster
-----------
| Navigation |
| ----- |
| [[#Check if network route is ok]] |
| [[#Initializing your control-plane node]] |
| [[#Make kubectl available for users]] |
| [[#Set the correct config file file the root user / sudo]] |
| [[#Adding nodes to the cluster]] |
| [[#Install Cilium CNI]] |
| [[#Troubleshooting]] |

## Check if network route is ok
```
$ ip route show # Look for a line starting with "default via"
```
## Initializing your control-plane node
```
sudo kubeadm init /
--skip-addon=kubeproxy /
--cluster-endpoint=<dns_name_of_the_apiserver>
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

## Make kubectl available for users:
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
## Adding nodes to the cluster
```
kubeadm join 172.24.1.81:6443 --token xxxxx --discovery-token-ca-cert-hash sha256:
```
if you cannot find the token you can list it
```
$ kubeadm token list
```
REBOOT


## Install Cilium CNI

Check [[install_cilium_cni]] documentation for implementing the CNI
This step can also be executed before adding all the nodes to the cluster

## Troubleshooting

kubeadm checks
```$ kubeadm cluster-info
kubectl get nodes
kubectl checks
```

Tools:
`crictl
`ctr
