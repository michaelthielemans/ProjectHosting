# Check the Gateway resource

```
kubectl get gateway -A
NAMESPACE                   NAME                 CLASS    ADDRESS          PROGRAMMED   AGE
website                     http-gateway         cilium   172.21.255.202   True         5h
webshop                     tls-gateway          cilium   172.21.255.203   True         5h
```
>The preceding command returns an overview of all the Gateways in the cluster. Check the following:

Is the Gateway programmed?

A programmed Gateway means that Cilium prepared a configuration for it.
If the Programmed true indicator is missing, make sure that Gateway API is enabled in the Cilium configuration.
Does the gateway have an address?
You can check the service with kubectl get service. If the gateway has an address, it means that a LoadBalancer service is assigned to the gateway. If no IP appears, you might be missing a LoadBalancer implementation.

Is the class cilium?
Cilium only programs Gateways with the class cilium.

If the Gateway API resource type (Gateway, HTTPRoute, etc.) is not found, make sure that the Gateway API CRDs are installed.
You can use kubectl describe gateway to investigate issues more thoroughly.

```
kubectl describe gateway <name>

  Conditions:
    Message:               Gateway successfully scheduled
    Reason:                Accepted
    Status:                True
    Type:                  Accepted
    Message:               Gateway successfully reconciled
    Reason:                Programmed
    Status:                True
    Type:                  Programmed
    [...]
  Listeners:
    Attached Routes:  2
    Conditions:
      Message:               Listener Ready
      Reason:                Programmed
      Status:                True
      Type:                  Programmed
      Message:               Listener Accepted
      Reason:                Accepted
      Status:                True
      [...]
```

>You can see the general status of the gateway as well as the status of the configured listeners.
Listener status displays the number of routes successfully attached to the listener.
You can see status conditions for both gateway and listener:

- Accepted: the Gateway configuration was accepted.
- Programmed: the Gateway configuration was programmed into Envoy.
- ResolvedRefs: all referenced secrets were found and have permission for use.
If any of these conditions are set to false, the Message and Reason fields give more information.
