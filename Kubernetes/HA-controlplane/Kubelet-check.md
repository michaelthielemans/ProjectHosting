# check if the kubelets of all the worker nodes correctly configured

check the kubelet configuration at
```
cat /etc/kubernetes/kubelet.conf
```

In this file you can see the api-server endpoint that the kubelet is using .
