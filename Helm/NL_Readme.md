![image](https://github.com/michaelthielemans/ProjectHosting/assets/119003253/68794ecc-934f-4ea6-9823-cc4e35f85dd6)


Beheerder : Janssen Niels

Verantwoordelijke : Janssen Niels

## 1. Table of Contents 

| Navigation |             
| :-------------------------------------------------  |
| [1. Table of Contents](#1-table-of-contents)             |
| [2. Overview](#2-overview)  |
| [3. Prerequisites](#3-prerequisites)                     |
| [4. Procedure](#4-procedure)       |
| [5. Uitvoering](#5-uitvoering)         |

## 2. Overview 

Helm is een pakketmanager die ervoor zorgt om in kubernetes op een gemakkelijke manier applicaties te installeren. 
In onze opstelling wordt Helm gebruikt om lemp-stacks uit te rollen voor onze klanten op een efficiënte manier. 
Dit zorgt ervoor dat we niet door de lijnen moeten scrollen maar in een beknopte "values.yaml" file slechts enkele variabelen moeten aanpassen.
Deze kunnen we dan gebruiken om onze lemp stack uit te rollen naar de noden van onze klant. 

De folderstructuur van de helm folder ziet er als volgt uit. 

mijnchart/
  Chart.yaml          # Een YAML-bestand met informatie over de chart
  values.yaml         # De standaard configuratiewaarden voor deze chart
  charts/             # Een map met eventuele afhankelijkheden voor de chart
  templates/          # Een map met sjabloonbestanden
    deployment.yaml   # Een sjabloon voor een Kubernetes Deployment
    service.yaml      # Een sjabloon voor een Kubernetes Service
    ingress.yaml      # Een sjabloon voor een Kubernetes Ingress
    _helpers.tpl      # Een sjabloon voor hulpprogramma's (macros)
  .helmignore         # Een bestand om bestanden te negeren bij het inpakken van de chart
  README.md           # Optioneel: Een README-bestand voor de chart
  values.schema.json  # Optioneel: Een JSON-schema voor het valideren van values.yaml
  templates/tests/    # Optioneel: Een map met tests
    test-connection.yaml  # Een testsjabloon om de verbinding te controleren


## 3. Prerequisites

De volgende hoofdstukken moeten voltooid zijn om de ontplooiing die dadelijk besproken wordt te kunnen verwezelijke. 

1. Kubernetes Cluster
2. TrueNAS
3. Cloudflare

## 4. Procedure

1. Installeer Helm
2. Maak de [Helm folder](/Helm) beschikbaar op de kubernetes cluster.
3. Package de helm folder
4. Open de mail waar de aanvraag van de klant staat. 
5. Pas de [values.yaml](/Helm/lemp-klanten/values.yaml) file aan de hand van de mail.
6. voer de helm install uit.
8. Controlleer dat de deployment correct werkt.  

## 5. Uitvoering 

Met het volgende commando installeren we Helm: 

```curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash```

Maak nu de [Helm folder](/Helm) beschikbaar op de kubernetes cluster. 
Dit kan bijvoorbeeld door nfs, sftp, scp,... 

Package de helm folder.

```sudo helm package lemp-klanten```

Pas de [values.yaml](/Helm/lemp-klanten/values.yaml) aan naar de noden van de klant. 

Als alle aanpassingen gedaan voer dan het volgende commando uit om de deployment voor de klant uit te voeren. 

```helm install klant2 lemp-klanten-0.1.0.tgz -f lemp-klanten/values.yaml```

controleer als de deployment correct werkt. 

```kubectl get pods -n ns-klanten```

![image](https://github.com/michaelthielemans/ProjectHosting/assets/119003253/12c8d7a3-965a-4330-acf4-7d55cadc9201)


