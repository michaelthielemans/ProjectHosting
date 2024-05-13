1[gatewayap](https://gateway-api.sigs.k8s.io/images/logo/logo-text-horizontal.png)
# Installing gateway api

Gateway api uses specific CRD ( custom resource definitions) these are not installed on a kubernetes cluster by default.

### install additional CRDs :
```
kubectl apply -f https://raw.githubusercontent.com/kubernetes-sigs/gateway-api/v1.0.0/config/crd/standard/gateway.networking.k8s.io_gatewayclasses.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes-sigs/gateway-api/v1.0.0/config/crd/standard/gateway.networking.k8s.io_gateways.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes-sigs/gateway-api/v1.0.0/config/crd/standard/gateway.networking.k8s.io_httproutes.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes-sigs/gateway-api/v1.0.0/config/crd/standard/gateway.networking.k8s.io_referencegrants.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes-sigs/gateway-api/v1.0.0/config/crd/experimental/gateway.networking.k8s.io_grpcroutes.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes-sigs/gateway-api/v1.0.0/config/crd/experimental/gateway.networking.k8s.io_tlsroutes.yaml
```

### make sure that cilium cli is installed
### clone the cilium git repository for pulling the 

```
git clone git@github.com:cilium/cilium.git
cd cilium
```
### install gateway api with cilium cli with the input of a helm chart  
```
cilium install --chart-directory ./install/kubernetes/cilium \
--set kubeProxyReplacement=true \
--set gatewayAPI.enabled=true
```


# Gateway api architecture

![gatewayapiarchitecture](https://gateway-api.sigs.k8s.io/images/resource-model.png)
