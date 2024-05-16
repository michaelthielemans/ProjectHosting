# cilium questions
1. Troubleshooting and logs
2. BGP and cilium loadbalancing
3.   Where is the bgp control plane physically running
4.   Do you need to add all nodes to the neighbors list of the router?
5. Is a service like nodeport/clusterIP a configuration that is applied to the kube-proxy daemon?
6. Can you point a gateway API directly to a app/pod or better always create a clusterIP service as a endpoint?
7. Ingress API is replaced with Gateway API ?
8. Ingress controller needed a proxy pod to run , what is Gateway API using ? Pod?
9. What about the firewall on or nodes => kube-proxy is replace with cilium, but it doesn't use iptables anymore? -> 
