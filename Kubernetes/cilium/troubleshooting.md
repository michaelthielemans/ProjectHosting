


```
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






# cilium questions
Can you point a gateway API directly to a single app/pod or better always create a clusterIP service as a endpoint?
ja altijd een cluster IP service aanmaken -> daarop kan worden ingehaakt met gateway api.



storage inside the cluster
ebs van amazon.

## deployments:
limit: hard limit
request : toegevewen = gegarandeerd
