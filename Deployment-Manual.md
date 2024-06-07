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
| [5.1 Analysis customer requirements ](#51-virtual-machine-overview)     |
| [5.2 Creation of NFS share](#52-truenas-installer)           |
| [5.3 Cloudflare DNS + Deployment](#52-truenas-installer)           |
| [5.4 Prepare Helm](#52-truenas-installer)           |
| [5.5 Generate database credentials Vaultwarden](#52-truenas-installer)           |
| [5.6 Complete values.yaml](#52-truenas-installer)           |
| [5.7 Deploy Helm chart](#52-truenas-installer)           |


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
|                                | Home Directory Permissions   | Read, Write, Execute                     |
|                                |                              | User                                     |
|                                |                              | Group                                    |
|                                |                              | Other                                    |
|                                | Create Home Directory        |  ❌                                        |
| Authentication                 | Authorized Keys              |  ❌                                        |
|                                | SSH password login enabled   |     ✅                                     |
|                                | Shell                        | nologin                                  |
|                                | Lock User                    |    ❌                                      |
|                                | Allowed sudo commands        |      ❌                                    |
|                                | Allow all sudo commands      |    ❌                                      |
|                                | Allowed sudo commands with no password |   ❌                                       |
|                                | Allow all sudo commands with no password |   ❌                                       |
| Samba Authentication           |                              |      ❌                                    |



## 5.4 Cloudflare DNS + Deployment

## 5.5 Prepare Helm 

## 5.6 Generate database credentials Vaultwarden

## 5.7 Complete values.yaml

## 5.8 Deploy Helm chart

## 5.9 Test deployment 

