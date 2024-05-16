# Cilium BGP Control Plane - with cilium version 1.16-pre.2

## Install with HELM
```
helm upgrade cilium ./cilium \
    --namespace kube-system \
    --reuse-values \
    --set bgpControlPlane.enabled=true
kubectl -n kube-system rollout restart ds/cilium
```

## Install with cilium cli
```
cilium upgrade --version 1.16.0-pre.2 --set bgpControlPlane.enabled=true
```
## checks
```
cilium config view
-> check ipam = cluster-pool
```




## Settings

> All BGP peering topology information is carried in a CiliumBGPPeeringPolicy CRD.
A CiliumBGPPeeringPolicy can be applied to one or more nodes based on its nodeSelector field. Only a single CiliumBGPPeeringPolicy can be applied to a node
If multiple policies match a node, Cilium clears all BGP sessions until only one policy matches the node.

>Each CiliumBGPPeeringPolicy defines one or more virtualRouters.
The virtual router defines a BGP router instance which is uniquely identified by its localASN. Each virtual router can have multiple neighbors defined.
The neighbor defines a BGP neighbor uniquely identified by its peerAddress and peerASN.
When localASN and peerASN are the same, iBGP peering is used. When localASN and peerASN are different, eBGP peering is used.


⚠️ Make sure to only create 1 peeringpolicy !!!!




### Check BGP peering

```
cilium bgp peers
```
