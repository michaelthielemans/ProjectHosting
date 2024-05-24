#kubernetes #cilium #documentation 
# Deploying CNI - the cilium pod network !
| Navigation                                         |
| -------------------------------------------------- |
| [[#Install the Cilium CLI]]                        |
| [[#Check if each node has a Internal IP assigned]] |
|                                                    |

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

## Check if each node has a Internal IP assigned

Please ensure that kubelet’s --node-ip is set correctly on each worker if you have multiple interfaces. Cilium’s kube-proxy replacement may not work correctly otherwise. You can validate this by running kubectl get nodes -o wide to see whether each node has an InternalIP which is assigned to a device with the same name on each node.

```
kubectl get nodes -o wide
```

## !-ONLY-! for existing installations with kube-proxy running as a DaemonSet

If you initialized the new cluster with the default addons, kube-proxy will be enabled and running. Cilium can replace this addon with a eBPF based alternative.
Remove it by using the following commands below.
Be aware that removing kube-proxy will break existing service connections. It will also stop service related traffic until the Cilium replacement has been installed.
```
kubectl -n kube-system delete ds kube-proxy
# Delete the configmap as well to avoid kube-proxy being reinstalled during a Kubeadm upgrade (works only for K8s 1.19 and newer)
kubectl -n kube-system delete cm kube-proxy
# Run on each node with root permissions:
iptables-save | grep -v KUBE | iptables-restore
```

## Download and extract the Cilium release

When you use this method you don't need to install it with helm. This is the cli based installation method.
The command below will download the tarball and change to the cilium install directory:
```
curl -LO https://github.com/cilium/cilium/archive/main.tar.gz
tar xzf main.tar.gz
cd cilium-main/install/kubernetes
```
## Install cilium from the CLI

## ⚠️ adjust the ownership of the /opt/cni/bin directory ON ALL THE NODES ⚠️
during installation, cilium will create a couple of pods. the cilium-xxxx pods will pull some data from the /opt/cni/bin folder. by default this folder is not owned by root, change it to root
```
sudo chown root:root /opt/cni/bin
```

### install Cilium CNI with
- the default kubeproxy replaced with cilium
- loadbalancing enabled on interfaces eth0,net0
- kubeproxyreplacement
- externalIP enabled
- internal clusternetwork encrypted


> This is for cloning the cilium git repo to you local disk, this not not needed if you already downloaded the files with curl to download and extract the tar release.
```
git clone git@github.com:cilium/cilium.git
cd cilium directory
```


```
sudo cilium install --version 1.16.0-pre2 \
  --chart-directory ./install/kubernetes/cilium \
  --set kubeProxyReplacement="true" \
  --set l2announcements.enabled=true \
  --set l2announcements.leaseDuration="3s" \
  --set l2announcements.leaseRenewDeadline="1s" \
  --set l2announcements.leaseRetryPeriod="500ms" \
  --set externalIPs.enabled=true \
  --set encryption.enabled=true \
  --set encryption.type=wireguard \
  --set devices=ens33 \
  --set gatewayAPI.enabled=true \
```

### With helm (not complete check official documentation)
```
helm install cilium ./cilium \
  --namespace kube-system \
  --set encryption.enabled=true \
  --set encryption.type=wireguard \
```

### Validate the installation
```
cilium status --wait
kubectl -n kube-system get pods --watch

cilium connectivity test --single-node
cilium connectivity test
```
#### validating encryption
>exec into the cilium pod
`kubectl -n kube-system exec -ti ds/cilium -- bash`
>Once inside the pod run:
`cilium-dbg status | grep Encryption`

Check if the kubeproxyreplacement is true -> this means that the default kube-proxy addon is completely replaced by cilium
```
kubectl -n kube-system exec ds/cilium -- cilium-dbg status | grep KubeProxyReplacement
```
---------------------
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
