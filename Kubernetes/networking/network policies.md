# Network policies

Define rules how network traffic should behave.

> When using cilium cni you can use cilium specific network policies , these have more finegrained rules


## Out-of-the-box kubernetes Network policy manifest file
```
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: allow-internal-traffic
  namespace: klant1
spec:
  podSelector: {}
  policyTypes:
  - Ingress
  - Egress
  ingress:
  - from:
    - podSelector: {}
  egress:
  - to:
    - podSelector: {}
```

### Explanation
- apiVersion:  networking.k8s.io/v1: Specifies the API version.
- kind: NetworkPolicy: Specifies that this is a NetworkPolicy resource.
- metadata: Contains the name and namespace of the NetworkPolicy.
- name: The name of the NetworkPolicy (allow-internal-traffic).
- namespace: The namespace where the policy is applied (klant1).
- spec: Defines the specifications of the NetworkPolicy.
- podSelector: {}: This applies to all pods in the klant1 namespace.
- policyTypes: Specifies the types of policies being applied. Here, both ingress and egress policies are defined.
- ingress: Specifies the ingress rules.
- from: Defines the sources of allowed ingress traffic.
- podSelector: {}: Allows traffic from any pod within the same namespace.
- egress: Specifies the egress rules.
- to: Defines the destinations of allowed egress traffic.
- podSelector: {}: Allows traffic to any pod within the same namespace.
