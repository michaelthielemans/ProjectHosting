# On-prem or in the cloud?
- On-prem servers are made available to us. No need to rent cloud infrastructure.

## Operating system we will use?
- Debian 👍 
- ubuntu 
- Rocky Linux

## kubernetes deployment method?
- kubeAdm 👍
- rancher 
- kubespray

## Storage for the cluster:
- Block storage? object storage? or file persona storage?
- KubeFS ? (CNCF incubating state)
- ROOK ? (CNCF graduate) Ceph cluster ?
- MINio - object storage
- longhorn -> when using rancher
- trueNAS can deliver block, object and file storage (S3,block zfs, ,NFS,..).  👌 

## Kubernetes pod networking = CNI cluster Network Interface
- CNI: cilium 👌 

## Kubernetes ingress controller:
- NGINX ingress 👌 

## External reverse proxy needed?
??????

## automatisation
- ansible 👍 
     - Dedicated VM for ansible
     - install ansible AWX
- puppet -> only if we have the spare time to deploy it.

## Monitoring
- Prometheus + alert manager + Grafana dashboard 👍 
- network monitoring ....

## Security dashboard
- Wazuh 👌

## key management and key vault
- hashicorp vault

## CI/CD pipeline
- argo CD
- github actions <--
- jenkins
- gitLab
- circleCI
