# On-prem or in the cloud?
- On-prem servers are made available to us. No need to rent cloud infrastructure.

# Hypervisor:
VMWare ?
XCP-NG ?

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

## Backups
- on hypervisor level👍 
- truenas level👍 
- optionally Veeam K10
  
## Monitoring
- Prometheus + alert manager + Grafana dashboard 👍 
- network monitoring ....

## Security dashboard
- Wazuh 👌

## password management and secretes, certificates and key vault
- hashicorp vault👍
- passbolt for credential sharing 👍
  -> + encrypted backups locally

## HTTPS/TLS and PKI infra
### Certificat authority service:
     - letsencrypt as a authority -> signed for only 90 days
     - combell (if it is free)
### HTTPS offloading
     - Ingress controller , NGINX
### certificate auto renewal
     - Jetstack’s cert-manager ( letsencrypt is supported)
     - cert manager has r/w access to the secrets (certificate and private key) and are stored in the vault

     Job of the certificate manager :
          issue certs to the ingress controller
          - auto renew certificates at set intervals
          - certmanager needs to prove that it has the ownership of the domain we are using against letsencrypt

## DNS
- dns registrar = combell👍 
- > should be free for students
- geen eigen DNS server
- cloudflare dns 'filter' 👍 

## CI/CD pipeline
- argo CD
- github actions <--
- jenkins
- gitLab
- circleCI
