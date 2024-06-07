Beheerder : Janssen Niels

Verantwoordelijke : Janssen Niels

## 1. Table of Contents 

| Navigation |             
| :-------------------------------------------------  |
| [1. Table of Contents](#1-table-of-contents)             |
| [2. Overview](#2-Overview)  |
| [3. Prequisites](#3-prerequisites)                     |
| [4. Procedure](#4-procedure)       |
| [5. Execution](#5-execution)         |
| [5.1 Analysis customer requirements](#51-analysis-customer-requirements)     |
| [5.2 Creation of NFS share](#52-creation-of-nfs-share)           |
| [5.3 Cloudflare DNS + Deployment](#53-cloudflare-dns-+-deployment)           |
| [5.4 Prepare Helm](#54-prepare-helm)           |
| [5.5 Generate database credentials Vaultwarden](#55-Generate-database-credentials-Vaultwarden)           |
| [5.6 Complete values.yaml](#56-complete-values.yaml)           |
| [5.7 Deploy Helm chart](#57-deploy-helm-chart)           |


## 2. Overview

Dit document is een complete procedure die omvat wat je moet doen als er een aanvraag van de klant bij ons toekomt voor het ontplooien van een webserver. 

## 3. Prerequisites 

De volgende hoofstukken dienen eerst uitgevoerd te worden alvorens dit modelijk is.

1. VMWare
2. Kubernetes Cluster
3. TrueNAS
4. Wazuh
5. Cloudflare
6. Helm
7. Adminer

## 4. Procedure

1. Analyse mail van de klant.
2. Aanmaken Share voor de klant op TrueNAS + 2 subfolders "/wordpress" & "/database".
3. Cloudflare DNS configureren + Cloudflare deployment aanpassen.
4. Helm klaarzetten
5. Database credentials genereren in Vaultwarden en invullen in de Helm values.yaml
6. Values.yaml verder aanvullen
7. Helm chart deployen

## 5. Execution

## 5.1 Analysis customer requirements 

open de [linux project hosting mailbox](http://www.gmail.com) en analyseer de binnengekomen aanvraag. 


## 5.2 Creation of NFS share 

Surf naar  [de TrueNAS webinterface](http://172.24.1.99) en log in met je credentials. 

In het dashboard open het tabblad Shares en klik daar in het venster "UNIX (NFS) Shares" op "ADD" .

![image](https://github.com/michaelthielemans/ProjectHosting/assets/119003253/a510ac07-8b94-4d58-a015-ac865defef67)

Navigeer onder "Path" naar /mnt/Maint/Klanten. Selecteer "Klanten" en klik op Create Dataset. 

Vul hier de ID van de klant in die je terugvindt in de mail en klik vervolgens op "Create". 

![image](https://github.com/michaelthielemans/ProjectHosting/assets/119003253/2af040c4-bda7-4324-afdd-484babe9861b)

1. Geef deze share een duidelijke description. (vb. Share klant 3 
2. Maak de user "Root" de <Maproot User>.
3. Onder <Networks> -> <Network> Beperk de range die deze NFS Share mag gebruiken tot "172.24.1.0/24".
4. Klik vervolgens op "Save"

![image](https://github.com/michaelthielemans/ProjectHosting/assets/119003253/7bfefdad-6180-4778-977d-b5854239204d)

## 5.3 Enable SFTP 

Om SFTP correct te laten werken moeten we eerst controleren dat de SSH service aanstaat. 
Klik op het tab System Settings -> Services en zet de service aan als dit nog niet het geval is. 
Klik vervolgens op het potlood in het tab van de SSH Service en controlleer de instellingen. 

| Configuration                  | Value |
|--------------------------------|-------|
| TCP Port                       | 22    |
| Allow Password Authentication  | ✅  |
| Allow Kerberos Authentication  | ❌   |
| Allow TCP Port Forwarding      | ✅  |

![image](https://github.com/michaelthielemans/ProjectHosting/assets/119003253/1d71701d-08b9-4174-8aab-b8649d9029d5)

Vervolgens gaan we een user account aanmaken voor deze klant waarmee hij via SFTP kan connecteren naar zijn share. 

Eerst gaan we een paswoord genereren voor de user. Surf hiervoor naar [Vaultwarden](https://vaultwarden.bloedlinks.app). 
Het kan zijn dat je je eerst moet authentificeren met cloudflare. Vul je email adres in en controleer je mailbox voor de verificatie code. Vul deze vervolgens in. 

![image](https://github.com/michaelthielemans/ProjectHosting/assets/119003253/d5a0e178-27b7-4fde-920e-8500e5184db5)

Klik in het linker tablad van het dashboard op de organisatie Linux Project Hosting en vervolgens op Nieuw -> Item

![image](https://github.com/michaelthielemans/ProjectHosting/assets/119003253/866f974f-ba1b-47ea-92b7-62ef8126027b)

Vul nu de informatie van de klant in en genereer een wachtwoord voor hem. Kopieer dit en gebruik het voor de klant zijn account in TrueNAS. Sla vervolgens de credentials van de klant tijdelijk op in Vaultwarden. 

![image](https://github.com/michaelthielemans/ProjectHosting/assets/119003253/defe2ea4-22b8-409d-b3e4-d047c9ed075f)

In de TrueNAS webinterface: 

Navigeer in het dashboard aan de linkerkant naar Credentials -> Local Users.
Klik in de rechterbovenhoek op "Add" en vul hier de gegevens van de klant in samen met het paswoord dat we net gegenereerd hebben. 

Voorbeeld: 

| Section                        | Field                        | Value                                    |
|--------------------------------|------------------------------|------------------------------------------|
| Identification                 | Full Name                    | Klant3                                   |
|                                | Username                     | klant3                                   |
|                                | Email                        | klant3@gmail.com                         |
|                                | Disable Password             |   ❌                                       |
|                                | Password                     | ••••••                                   |
|                                | Confirm Password             | ••••••                                   |
| User ID and Groups             | UID                          | 3007                                     |
|                                | Create New Primary Group     |    ✅                                      |
|                                | Auxiliary Groups             |     ❌                                     |
|                                | Primary Group                |     ❌                                     |
| Directories and Permissions    | Home Directory               | /mnt/Maint/Klanten/klant3                |
|                                | Home Directory Permissions   |                      |
|                                |                              | User Read ✅, Write✅, Execute✅                                 |
|                                |                              | Group     Read ❌, Write ❌, Execute ❌                               |
|                                |                              | Other     Read ❌, Write ❌, Execute ❌                                |
|                                | Create Home Directory        |     ❌                                     |
| Authentication                 | Authorized Keys              |  ❌                                        |
|                                | SSH password login enabled   |     ✅                                     |
|                                | Shell                        | nologin                                  |
|                                | Lock User                    |    ❌                                      |
|                                | Allowed sudo commands        |      ❌                                    |
|                                | Allow all sudo commands      |    ❌                                      |
|                                | Allowed sudo commands with no password |   ❌                                       |
|                                | Allow all sudo commands with no password |   ❌                                       |
| Samba Authentication           |                              |      ❌                                    |

![image](https://github.com/michaelthielemans/ProjectHosting/assets/119003253/60257036-4472-4afe-a990-271858fac843)

Klik vervolgens op "Save" beneden in het venster. 

Open Filezilla, test de SFTP Connectie en maak 2 subfolders aan: "wordpress" en "database" 

![image](https://github.com/michaelthielemans/ProjectHosting/assets/119003253/cafe0977-dcb5-463c-a995-d1c40844f4ac)

## 5.4 Cloudflare DNS + Deployment

Vervolgens moeten we voor de klant zijn domeinnaam tunnelen naar de kubernetes namespace: ns-klanten. Surft naar [Cloudflare](https://www.cloudflare.com) en log in. 
Navigeer vervolgens naar Zero Trust -> Networks -> Tunnels. Als de tunnel "to-thomasmore" niet bestaat  [volg dan het volgende hoofdstuk](/Cloudflare/Readme.md).

![image](https://github.com/michaelthielemans/ProjectHosting/assets/119003253/ea9044f7-aff1-47d3-8500-b039f8414601)

Klik op de drie bolletjes bij de "to-thomasmore" tunnel, dan op "Configure" -> "Public Hostnames" -> Add a public hostname. 

![image](https://github.com/michaelthielemans/ProjectHosting/assets/119003253/c80bfa7c-3bbd-47aa-a748-547d3e41bd09)

Vul de parameters in zoals in onderstaande afbeelding aangegeven staat en klik op Save. 
(Achterliggend wordt er automatisch een CNAME record aangemaakt die door de tunnel naar je klant zijn NGINX pod verwijst) 

![image](https://github.com/michaelthielemans/ProjectHosting/assets/119003253/4c9a62b0-c14f-40d8-b236-0dd86be5747d)

ssh vervolgens naar een masternode en pas de cloudflare deployment file aan met de informatie die je zonet in cloudflare hebt ingegeven. 

![image](https://github.com/michaelthielemans/ProjectHosting/assets/119003253/8fa3c1c9-762c-4ecb-923b-fc0c49186e9e)

```kubectl apply -f <cloudflare-deployment.yaml```

## 5.5 Prepare Helm 

Bereid de [helm folderstructuur](/Helm) voor op een masternode. 

## 5.6 Generate database credentials Vaultwarden

Open je vaultwarden tabblad opnieuw en maak een nieuwe entry aan voor de database van de klant. Kopiëer vervolgens zijn wachtwoord. 

![image](https://github.com/michaelthielemans/ProjectHosting/assets/119003253/4d600ddc-8ffc-4b91-89a8-d2dbd8fbb145)

Op de master node gaan we nu de volgende informatie encoderen naar "base64".

1. Database user = db-user
2. Database wachtwoord = <database-wachtwoord>
3. Database naam = wordpress-db
4. Database root wachtwoord = <database-root-wachtwoord>

gebruik hiervoor het volgende commando of [deze website](https://www.base64decode.org/)

```echo -n "<string>" | base64```

![image](https://github.com/michaelthielemans/ProjectHosting/assets/119003253/8130dfb7-037e-41b0-bc39-e9f4b63c57f5)

Kopiëer het wachtwoord


## 5.7 Complete values.yaml

Open nu de values.yaml file. 

```nano values.yaml```

Vul de klant zijn informatie verder in aan de hand van de aanvraag en informatie die we zonet gegenereerd hebben. 

![image](https://github.com/michaelthielemans/ProjectHosting/assets/119003253/65f57314-a5fb-4d7b-9c06-198bb449de3b)

```
identifier: "klant3"
namespace: "ns-klanten"
resourceTier: "medium"

dbCredentials:
  user: ZGItdXNlcg==
  password: eUd6WnFKS0Q0WXpaTVJ0c2ttb3BRYQ==
  dbName: d29yZHByZXNzLWRi
  rootPassword: cm9vdC1wYXNzd29yZA==
  mysqlDatabase: d29yZHByZXNzLWRi
  mysqlUser: ZGItdXNlcg==
  mysqlPassword: eUd6WnFKS0Q0WXpaTVJ0c2ttb3BRYQ==

wordpress:
  phpVersion: "8.1-fpm" # Options: 7.4-fpm, 8.1-fpm

database:
  type: "mariadb" # Options: mariadb, mysql
  version: "10.6" # Options for mariadb: 10.6, 10.5, 10.4; Options for mysql: 5.7, 8.0


resources:
  low:
    requests:
      memory: "256Mi"
      cpu: "500m"
    limits:
      memory: "512Mi"
      cpu: "800m"
  medium:
    requests:
      memory: "512Mi"
      cpu: "800m"
    limits:
      memory: "1024Mi"
      cpu: "1000m"
  high:
    requests:
      memory: "1024Mi"
      cpu: "1000m"
    limits:
      memory: "2048Mi"
      cpu: "2000m"

nfs:
  server: "172.24.1.99"
  path: "/mnt/Maint/Klanten/klant2"

service:
  port: 80

serviceAccount:
  create: true
  name: ""
```

## 5.8 Deploy Helm chart





## 5.9 Test deployment 

