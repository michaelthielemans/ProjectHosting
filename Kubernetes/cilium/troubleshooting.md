### Gateway api and clusterIP
When working with gateway API always point to a ClusterIP service. Even when there is only one pod you want to reach.

```
### l2announcements
```
kubectl get CiliumL2AnnouncementPolicy
kubectl describe ciliuml2announcementpolicies.cilium.io
```
### ippools
```
kubectl get ciliumloadbalancerippools.cilium.io -o wide
kubectl describe ciliumloadbalancerippools.cilium.io
```

## deployments:
limit: hard limit
request : toegevewen = gegarandeerd
