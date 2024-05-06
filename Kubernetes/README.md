# Test cluster
- Masternode available at : 172.24.1.81
- Helm is installed
- Persistent volumes are tested and can be used.
- Only NodePort service can be used -> ingress controller not yet installed

# kubectl cli tool:
kubectl is installed on the masternode
## using kubectl on your local machine
1. Install kubectl cli tool
2. copy the config file from the masternode to you own computer
     -> the config file is ->  ~/.kube/config
4. on linux/mac :
   ```
   export KUBECONFIG/path/to/kubectl/config
   ```
5. use kubectl without the need for ssh login to the masternode !!
