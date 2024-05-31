# Implementatie van een 'high-available' Kubernetes-control plane

### Aantal control plane-nodes
Het is best practice om 3 of 5 controller nodes te gebruiken.
Waarom: etcd is een datastore die gegevens zal repliceren op basis van quora. Als je een even aantal control plane-nodes hebt, bestaat de kans dat je een split-brain-scenario hebt.
Etcd zal beslissingen nemen op basis van een meerderheid van 50% + 1.

### Architectuur van de HA-control plane

3 controller nodes, voor deze nodes heb je een loadbalancer nodig die een VIP (virtueel IP) aanbiedt.

KUBE-VIP maakt gebruik van een statische pod op elke node.
> Statische pods zijn pods die worden gemaakt en beheerd door een kubelet op een node, in tegenstelling tot standaard PODS die door de de Kubernetes API-server aangemaakt.
> Wanneer de kubelet op een node een statisch pod-manifestbestand detecteert in een specifieke map,
> creëert het een pod uit het manifestbestand en beheert het de levenscyclus van de pod.
> Statische pods zijn nuttig in situaties waarin je een pod moet uitvoeren op een node die geen deel uitmaakt van een
> Kubernetes-cluster of wanneer je een pod wilt uitvoeren zonder afhankelijk te zijn van de Kubernetes API-server.
>
> Locatie van manifestbestanden voor statische pods = /etc/kubernetes/manifest
------
## Vereisten
Bereid de high available nodes voor zoals standaardnodes
[Bereid_node_voor_Kubernetes](Prepare_node_for_kubernets.md)

## Procedure: Initialisatie van een HA-cluster met kube-vip

1. Genereer een kube-vip manifestbestand en plak het in de map voor statische pods -> /etc/kubernetes/manifests/
2. Voer kubeadm init uit met de --control-plane-endpoint-vlag met het VIP-adres dat wordt geleverd bij het genereren van het statische pod-manifest.
3. Tijdens de kube-init-fase zal de kubelet alle manifesten parsen en uitvoeren, inclusief het kube-vip manifest dat is gegenereerd in stap één en de andere control plane-componenten inclusief kube-apiserver.
4. kube-vip start en adverteert het VIP-adres.
5. De kubelet op deze eerste control plane zal verbinding maken met het VIP-adres dat is geadverteerd in de vorige stap.
6. kubeadm init wordt met succes voltooid op de eerste control plane.
7. Gebruik de uitvoer van het kubeadm init-commando op de eerste control plane, voer het kubeadm join-commando uit op de overige control plane-nodes.
8. Kopieer het gegenereerde kube-vip manifest naar de overige control plane-nodes en plaats het in hun map voor statische pods (standaard /etc/kubernetes/manifests/)
	> je kunt het resultaat controleren door kubectl get pods -n kube-system uit te voeren

#### 1. Genereer het manifestbestand voor kube-vip
Stel het VIP virtuele IP in dat zal worden gebruikt op de control-plane en het actieve interface op de control nodes in:
` export VIP=172.24.1.60`
` export INTERFACE=ens33`

Controleer de nieuwste versie van kube-vip op [release-tag](https://github.com/kube-vip/kube-vip/releases)
en exporteer die versie
`export KVVERSION=v0.8.0`

Definieer de 'kube-vip' alias voor later gebruik:
>dit commando werkt alleen met de Containerd CRI

>[!warning] zorg ervoor dat je overschakelt naar de rootgebruiker voordat je de alias maakt!! anders kun je de alias niet uitvoeren met sudo-bevoegdheden

```
alias kube-vip="ctr image pull ghcr.io/kube-vip/kube-vip:$KVVERSION; ctr run --rm --net-host ghcr.io/kube-vip/kube-vip:$KVVERSION vip /kube-vip"
```


>[!attention] Let op: Wanneer je deze commando's uitvoert op een toekomstige control plane-node, kan sudo-toegang vereist zijn samen met voorafgaande creatie van de map /etc/kubernetes/manifests/.


##### Voor arp-type load-balancing gebruik het volgende commando:
>[!warning] voer dit commando uit als rootgebruiker

```
kube-vip manifest pod
--interface $INTERFACE
--address $VIP
--controlplane
--services
--arp
--leaderElection | tee /etc/kubernetes/manifests/kube-vip.yaml
```


De officiële documentatie vertelt je om het kubeadm init-commando uit te voeren. -> dit zal resulteren in een fout!! Omdat kubeadm init niet alle statische pods kan starten. kubeadm zal proberen een verbinding tot stand te brengen met het 'control-plane-endpoint' IP voor communicatie met de kubelet, het is de kubelet die alle statische pods zal starten. Het punt is dat de kube-vip op dat moment niet draait, dus het VIP waar kubeadm probeert verbinding mee te maken is niet beschikbaar. 
Dit kan worden opgelost door een regel toe te voegen aan het /etc/hosts-bestand. geef het een nieuwe DNS-naam en wijs het toe aan het IP-adres van de masternode (niet het VIP-adres). Gebruik deze DNS-naam in de --control-plane-endpoint parameter. pas later het hosts-bestand aan en wijs het toe aan de VIP.


>[!attention] Het IP-adres of de dns-naam die je hebt gedefinieerd als api-endpoint (voor VIP of niet-VIP) is gekoppeld aan het certificaat dat je nodig hebt om verbinding te maken met de api-server. dus wees ervan bewust dat zodra je een dns-naam hebt toegevoegd, je er niet rechtstreeks mee kunt verbinden met ip.

>[!attention] Vergeet ook niet om
>```
>modprobe br_netfilter
>```

Voer kubeadm uit met de parameters
```
kubeadm init --control-plane-endpoint dns-naam --upload-certs --skip-phases=addon/kube-proxy
```

> De --upload-certs vlag wordt gebruikt om de certificaten automatisch te uploaden die gedeeld moeten worden over de control-plane-instanties in de cluster.

## Samenvatting van commando's
```bash

export VIP=172.24.1.60
export INTERFACE=ens33
export KVVERSION=v0.8.0
alias kube-vip="ctr image pull
```
