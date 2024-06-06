# IP Pools
Manifest for creating a new pool
```
apiVersion: "cilium.io/v2alpha1"
kind: CiliumLoadBalancerIPPool
metadata:
  name: "blue-pool"
spec:
  blocks:
  - cidr: "10.0.10.0/24"  #allocate a subnet
  - cidr: "2004::0/64"    #allicate a IPv6 subnet
  - start: "20.0.20.100"  #start stop range
    stop: "20.0.20.200"
  - start: "1.2.3.4"
```
## create a ip pool that is matched to a service via a label
```
apiVersion: "cilium.io/v2alpha1"
kind: CiliumLoadBalancerIPPool
metadata:
  name: "blue-pool"
spec:
  blocks:
  - cidr: "20.0.10.0/24"
  serviceSelector:
    matchExpressions:
      - {key: color, operator: In, values: [blue, cyan]}
---
apiVersion: "cilium.io/v2alpha1"
kind: CiliumLoadBalancerIPPool
metadata:
  name: "red-pool"
spec:
  blocks:
  - cidr: "20.0.10.0/24"
  serviceSelector:
    matchLabels:
      color: red
```



### Check if the pool is created
```
kubectl get ippools
NAME        DISABLED   CONFLICTING   IPS AVAILABLE   AGE
blue-pool   false      False         65788           2s
```
## Disabling a Pool
IP Pools can be disabled. Disabling a pool will stop LB IPAM from allocating new IPs from the pool, but doesn’t remove existing allocations. This allows an administrator to slowly drain pool or reserve a pool for future use.
```
apiVersion: "cilium.io/v2alpha1"
kind: CiliumLoadBalancerIPPool
metadata:
  name: "blue-pool"
spec:
  blocks:
  - cidr: "20.0.10.0/24"
  disabled: true
```

#Production Cluster IP Pool
```
apiVersion: "cilium.io/v2alpha1"
kind: CiliumLoadBalancerIPPool
metadata:
  name: "prod-ippool"
spec:
  blocks:
  - start: "172.24.1.61"
    stop: "172.24.1.62"
```
