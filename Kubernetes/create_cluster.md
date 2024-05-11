

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

## export the KUBECONFIG alias if you are the root user
```
$ export KUBECONFIG=/etc/kubernetes/admin.conf
```

# Deploying the cilium pod network !
## Install the Cilium CLI
Installing cilium cni, hubble, ... can be done with cilium cli

```
cd
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

## First check if each node has a Internal IP assigned

Please ensure that kubelet’s --node-ip is set correctly on each worker if you have multiple interfaces. Cilium’s kube-proxy replacement may not work correctly otherwise. You can validate this by running kubectl get nodes -o wide to see whether each node has an InternalIP which is assigned to a device with the same name on each node.

```
kubectl get nodes -o wide
```


## For existing installations with kube-proxy running as a DaemonSet, remove it by using the following commands below.


Be aware that removing kube-proxy will break existing service connections. It will also stop service related traffic until the Cilium replacement has been installed.
```
kubectl -n kube-system delete ds kube-proxy
# Delete the configmap as well to avoid kube-proxy being reinstalled during a Kubeadm upgrade (works only for K8s 1.19 and newer)
kubectl -n kube-system delete cm kube-proxy
# Run on each node with root permissions:
iptables-save | grep -v KUBE | iptables-restore
```

Download the Cilium release tarball and change to the kubernetes install directory:
```
curl -LO https://github.com/cilium/cilium/archive/main.tar.gz
tar xzf main.tar.gz
cd cilium-main/install/kubernetes
```

# install cilium from the CLI

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
