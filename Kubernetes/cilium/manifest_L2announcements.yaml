apiVersion: "cilium.io/v2alpha1"
kind: CiliumL2AnnouncementPolicy
metadata:
  name: policy1
spec:
  serviceSelector:
    matchLabels:
      color: blue   # is this the a pointer to the clusterIP label of the service or gatewayAPI
  nodeSelector:
    matchExpressions:
      - key: node-role.kubernetes.io/control-plane
        operator: DoesNotExist
  interfaces:
  - ^eth[0-9]+    # how to find the correct  interfaces?
  externalIPs: true   # ???
  loadBalancerIPs: true   #  ????
