# Network Policies

On-line tool for helping you create network policy manifest files:
https://editor.networkpolicy.io

## NetworkPolicy Essentials
- Once you apply your first network policy for ALLOWING traffic, all other traffic within the namespace is DENIED.
- NP are always and only applied to PODS, never to services,...
- A networkpolicy is linked to a pod based on a LABEL
- 3 scopes:
  - cluster wide
  - within namespace
  - from outside the cluster
- 2 directions:
  - ingress
  - egress
 
