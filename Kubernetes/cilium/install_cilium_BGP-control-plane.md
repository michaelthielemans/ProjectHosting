#kubernetes #cilium #documentation 

>[!warning] -- BGP IS NOT USED IN OUR ENVIRONMENT --
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


# BGP configuration

> cilium will create a Virtual IP based on your CiliumBGPPeeringPolicy and announce it to its BGP neighbour routers.


## CiliumBGPPeeringPolicy manifest file:
```
apiVersion: cilium.io/v2alpha1
kind: CiliumBGPPeeringPolicy
metadata:
  name: example-bgp-peering-policy
  namespace: kube-system
spec:
  peers:
    - peerAddress: "192.168.1.1"
      peerASN: 65001
      myASN: 65000
  nodeSelector:
    matchLabels:
      kubernetes.io/hostname: "node1.example.com"
      bgp-enabled: "true"
  virtualRouters:
    - asn: 65000
      neighborConfigs:
        - peerAddress: "192.168.1.1"
          peerASN: 65001
      serviceSelector:
        matchLabels:
          app: my-app
---
apiVersion: "cilium.io/v2alpha1"
kind: CiliumBGPPeeringPolicy
metadata:
  name: rack0
spec:
  nodeSelector:
    matchLabels:
      rack: rack0
  virtualRouters:
  - localASN: 64512
    exportPodCIDR: true # <-- enable PodCIDR advertisement
    neighbors:
    - peerAddress: '10.0.0.1/32'
      peerASN: 64512
```


-  the nodeselector field can point to hostnames as wel as labels you have attached to nodes
-  attach a label to a node  ` kubectl label nodes node1 bgp-enabled=true`
