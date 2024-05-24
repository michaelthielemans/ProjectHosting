#documentation #kubernetes #cilium 
# cilium cli howto
You can install, configure , upgrade, delete cilium with the use of cilium-cli

## checking the status of cilium
```
cilium status --wait
```

## View and adjust the cilium configuration
Check the cilium main configuration
```
cilium config view
#you can also check the config with kubectl
kubectl -n kube-system get configmap cilium-config -o yaml
```

You can change any of these key: value pair settings
```
cilium config set key value
# for example
cilium config set ipam cluster-pool
```




## Troubleshooting and debugging
```
cilium sysdump
```
