# cilium questions
1. Ingress API is fully replaced with Gateway API ?
ja niks aantrekken van envoy envoy is gemanage door cilium
   
3. What is the go-to solution for loadbalancing? L2 anouncements or BGP

L2 announcement is simpel => go to solution
cluster IP zal achterliggend voor de loadbalancing zorgen. kan dus zijn dat de traffic naar een andere server moet
   
   
7. BGP and cilium loadbalancing:
  - Where is the bgp control plane physically running ?
  - Do you need to add all nodes to the neighbors list of the router? also the master nodes?
  - does each node need a router-id? is in fact each node a bgp enabled router?
  - BGP VIP , when using a IPpool does cilium choose a VIP from that pool
  - Host network mode : available since v1.16 -> can it be used together with loadbalancer mode?
3. Is a service like nodeport/clusterIP a configuration that is applied to the kube-proxy daemon?



4. Can you point a gateway API directly to a single app/pod or better always create a clusterIP service as a endpoint?
ja altijd een cluster IP service aanmaken -> daarop kan worden ingehaakt met gateway api.
   
6. What is a cilium agent? Are those the cilium pods? What is its job
   
8. Ingress controller needed a proxy pod to run , what is Gateway API using ? Pod? envoy proxy? Is this pod in fact 
  
   
11. What about the firewall on or nodes => kube-proxy is replace with cilium, but it doesn't use iptables anymore? -> is it now all handled by NetworkPolicies?


storage inside the cluster
ebs van amazon.


limit: hard limit
request : toegevewen = gegarandeerd
