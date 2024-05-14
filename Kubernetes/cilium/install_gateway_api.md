![gatewayap](https://gateway-api.sigs.k8s.io/images/logo/logo-text-horizontal.png)
# Installing gateway api

Gateway api uses specific CRD ( custom resource definitions) these are not installed on a kubernetes cluster by default.

### 1. install additional CRDs :
```
kubectl apply -f https://raw.githubusercontent.com/kubernetes-sigs/gateway-api/v1.0.0/config/crd/standard/gateway.networking.k8s.io_gatewayclasses.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes-sigs/gateway-api/v1.0.0/config/crd/standard/gateway.networking.k8s.io_gateways.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes-sigs/gateway-api/v1.0.0/config/crd/standard/gateway.networking.k8s.io_httproutes.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes-sigs/gateway-api/v1.0.0/config/crd/standard/gateway.networking.k8s.io_referencegrants.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes-sigs/gateway-api/v1.0.0/config/crd/experimental/gateway.networking.k8s.io_grpcroutes.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes-sigs/gateway-api/v1.0.0/config/crd/experimental/gateway.networking.k8s.io_tlsroutes.yaml
```

### 2. make sure that cilium cli is installed
### 3.a If you have a clean cluster and cilium is not yet installed:
```
cilium install --version 1.15.4 \
    --set kubeProxyReplacement=true \
    --set gatewayAPI.enabled=true
```
### 3.b If you have a cluster with cilium installed but not with gateway api enabled:
```
cilium install --version 1.15.4 \
    --set kubeProxyReplacement=true \
    --set gatewayAPI.enabled=true
    --set
### install gateway api with cilium cli with the input of a helm chart  
```
### 4. Reboot the masternode

## Verifying and troubleshooting
### Check if gateway api is successfully enabled
```
cilium config view | grep "enable-gateway-api"
```
### Let’s verify that a GatewayClass has been deployed and accepted:
```
kubectl get gatewayclasses.gateway.networking.k8s.io 
```
A gateway class is a settings blueprint where you can define which gateway type can be used in the cluster, it is possible to use more than one gateway type. In our case, we will instantiate Cilium Gateway API (io.cilium/gateway-controller).

# Gateway api architecture

![gatewayapiarchitecture](https://gateway-api.sigs.k8s.io/images/resource-model.png)
