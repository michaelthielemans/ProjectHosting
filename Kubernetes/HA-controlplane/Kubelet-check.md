# Check if the kubelets daemons are correctly installed on the workernodes:

```
cat /etc/kubernetes/kubelet.conf
```

In this file you can see the api-server endpoint that the kubelet is using .
It is the kubelet service on all the nodes that makes a connection to the api-server.
