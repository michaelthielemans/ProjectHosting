#documentation #automation
# Version Control System
👍 github

# Taken en Planning tool
- github projects
  Alle documentatie, configuratie, code, planning op hetzelfde platform 
  
# On-prem or in the cloud?
- on-premis
De school stelt ons on-premise server infrastructuur ter beschikking.

# Hypervisor:
- VMWare met vSphere

## Which operating system we will use?
- Debian gebaseerde distributie
  - UBUNTU -> veel documentatie beschikbaar

## kubernetes deployment method?
- kubeAdm: Dit is de meest compacte en toch simpele manier om een cluster op te bouwen. Weinig extra complexiteit of 'overhead'

## Storage for the cluster:
- trueNAS
  Is gebruiksvriendelijk en bied alle functionaliteiten aan die we nodig hebben.

## Kubernetes pod networking = CNI cluster Network Interface
- CNI: cilium
  Native ondersteuning op kubernetes, meest moderne CNI technologie.

## Kubernetes ingress controller:
- cilium gateway API
- cloudflare zero trust

## automatisation
- ansible
  zeer veelzijdige configuratie tool, van servers tot netwerk apparatuur.

## Backups
- vmware vSphere DataProtection -> extra licence? not available for us -> 3th party product can be expensive
- TrueNas - we maken reeds gebruik van trueNas dus geen extra software nodig om backups te maken
  
## Monitoring
- Prometheus + alert manager + Grafana dashboard
  wordt native ondersteund door kubernetes

## Security dashboard
- Wazuh : opensource, overzichtelijk dashboard, all in one security product

## password management and secretes, certificates and key vault
kubernetes secrets -> keep it stupid keep it simple, provided all we needed.
- passbolt for credential sharing
  -> + encrypted backups locally

## HTTPS/TLS and PKI infra
### Certificat authority service:
- letsencrypt as a authority -> signed for only 90 days
### HTTPS offloading
- cloud flare
### certificate auto renewal
- Jetstack’s cert-manager (letsencrypt is supported)
- cert manager has r/w access to the secrets (certificate and private key) and are stored in the vault

#### Job of the certificate manager :
- issue certs to the ingress controller
- auto renew certificates at set intervals
- certmanager needs to prove that it has the ownership of the domain we are using against letsencrypt

## DNS
- cloudflare dns 'filter'

## CI/CD pipeline
- github actions
  We maken reeds gebruik van github als VCS repository
