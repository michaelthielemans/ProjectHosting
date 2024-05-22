# Deploying a High available kubernetes control plane.

### Number of control plane nodes
Best practice is to use 3 or 5 controller nodes.
Why: etcd is a datastore dat will replicate data based on quora. If you have a even number of control plane nodes chances are that you have a split brain scenario. Etcd will make decisions based on 50% + 1 majority. 

### HA control plane architecture

3 controller nodes, in front of these nodes you need a loadbalancer that provides a VIP(virtual IP)

KUBE-VIP makes use of a static pod on each node
> Static Pods are pods that are created and managed by a kubelet on a node, rather than by the Kubernetes API server.
> When the kubelet on a node detects a static pod manifest file in a specific directory,
> it creates a pod from the manifest file and manages the pod’s lifecycle.
> Static Pods are useful in situations where you need to run a pod on a node that is not part of a
> Kubernetes cluster or when you want to run a pod without relying on the Kubernetes API server.
>
> Manifest files for static pods location = /etc/kubernetes/manifest
------
## Prerequisites
Prepare the nodes like standard nodes
[prepare-node](Prepare_node_for_kubernets.md)

## Procedure: HA Cluster initialization with kube-vip

1. Generate a kube-vip manifest file and paste it in manifest directory for static pods -> /etc/kubernetes/manifests/
2. Run kubeadm init with the --control-plane-endpoint flag using the VIP address provided when generating the static Pod manifest.
3. During the kube init phase the kubelet will parse and execute all manifests, including the kube-vip manifest generated in step one and the other control plane components including kube-apiserver.
4. kube-vip starts and advertises the VIP address.
5. The kubelet on this first control plane will connect to the VIP advertised in the previous step.
6. kubeadm init finishes successfully on the first control plane.
7. Using the output from the kubeadm init command on the first control plane, run the kubeadm join command on the remainder of the control plane nodes.
8. Copy the generated kube-vip manifest to the remainder of the control plane nodes and place in their static Pods manifest directory (default of /etc/kubernetes/manifests/)

#### 1. Generate the manifest file for kube-vip
Set the VIP virtual IP that will be used on the control-plane and the active interface on the control nodes:
` export VIP=<ip-address>`
` export INTERFACE=ens33`

Check the latest version of kube-vip on [release-tag](https://github.com/kube-vip/kube-vip/releases)
and export that version
`export KVVERSION=v0.8.0`

Define the 'kube-vip' alias for later use:
>this command only works with the Containerd CRI
```
alias kube-vip="ctr image pull ghcr.io/kube-vip/kube-vip:$KVVERSION; ctr run --rm --net-host ghcr.io/kube-vip/kube-vip:$KVVERSION vip /kube-vip"
```
>[!attention] Note: When running these commands on a to-be control plane node, sudo access may be required along with pre-creation of the /etc/kubernetes/manifests/ directory.


For arp type load-balancing use following command:

```
kube-vip manifest pod \
    --interface $INTERFACE \
    --address $VIP \
    --controlplane \
    --services \
    --arp \
    --leaderElection | tee /etc/kubernetes/manifests/kube-vip.yaml
```

Run kubeadm with the parameters
```
kubeadm init --control-plane-endpoint <VIP address> : <port> --upload-certs
```
  > --upload-certs flag is used to auto upload the certificates that should be shared across the control-plane instances in the cluster.
