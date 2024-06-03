![image](https://github.com/michaelthielemans/ProjectHosting/assets/119003253/a40ff127-84f0-46df-a5e7-285ff7b7a913)

Beheerder : Janssen Niels

Verantwoordelijke : Janssen Niels

## 1. Table of Contents 

| Navigation |             
| :-------------------------------------------------  |
| [1. Table of Contents](#1-table-of-contents)             |
| [2. Overview](#2-overview)  |
| [3. Prerequisites](#3-prerequisites)                     |
| [4. Procedure](#4-procedure)       |
| [5. Vaultwarden Rollout](#5-vaultwarden-rollout)         |
| [5.1 Generate Secret](#51-generate-admin-password)     |
| [5.2 Deploy Cloudflare](#52-deploy-cloudflare)           |
| [5.3 Deploy Vaultwarden](#53-deploy-vaultwarden)         |
| [5.4 Cloudflare Application Security](#54-cloudflare-application-security)         |
| [5.5 Configure Vaultwarden SNMP](#54-configure-vaultwarden-snmp)         |

## 2. Overview

Vaultwarden is een onofficiële implementatie van de Bitwarden password manager server. Oorspronkelijk bekend als Bitwarden_RS, is Vaultwarden ontworpen om een lichtgewicht en efficiënt alternatief te zijn voor de officiële Bitwarden server. Het is geschreven in Rust en biedt een zelf-gehoste oplossing voor diegenen die liever hun eigen wachtwoordopslag beheren in plaats van te vertrouwen op een dienst van derden.

Vaultwarden wordt ontplooit in de namespace "ns-management"

## 3. Prerequisites 

Om de Vaultwarden manifest file uit te rollen moet er eerst aan een aantal voorwaarden voldaan worden. 

1. De kubernetes cluster moet volledig uitgerold zijn
2. Cloudflare Zero Trust moet ontplooid zijn.

## 4. Procedure

1. Genereer een sterk admin paswoord doormiddel van argon2
2. Pas de [Cloudflare manifest file](/Cloudflare/namespace-management/Hosting/cloudflare-management.yaml) en [Cloudflare secrets file](/Cloudflare/namespace-management/Hosting/cloudflare-management-secret.yaml) aan die gekoppeld is aan de namespace "ns-management" en ontplooi deze
3. Pas de [Vaultwarden manifest file](vaultwarden.yaml) aan waar nodig en ontplooi deze
4. Configureer de Cloudflare application security
5. Configureer de SNMP settings in het admin dashboard

## 5. Vaultwarden Rollout

Eerst gaan we de namespace maken als deze nog niet bestaat.


```kubectl create namespace ns-management```

### 5.1 Generate Secret 

Om de vaultwarden admin token te beveiligen gaan we eerst hiervoor een secret genereren. 
encodeer je gewenst paswoord naar base64 (https://www.base64encode.org/)

pas de [secrets file](vaultwarden-secret.yaml) aan.

pas de file vervolgens toe 

```kubectl apply -f vaultwarden-secret.yaml ```

### 5.2 Deploy Cloudflare

Pas de volgende bestanden aan waar nodig en deploy ze vervolgens.

[Cloudflare-management-secret file](/Cloudflare/namespace-management/Hosting/cloudflare-management-secret.yaml)

[Cloudflare-management-deployment file](/Cloudflare/namespace-management/Hosting/cloudflare-management.yaml)

```kubectl apply -f cloudflare-management-secret.yaml ```

```kubectl apply -f cloudflare-management.yaml ```

### 5.3 Deploy Vaultwarden

Pas de volgende files aan waar nodig en deploy ze: 
[Vaultwarden deployment](vaultwarden.yaml) 
[Vaultwarden pv + pvc](vaultwarden-pv+pvc.yaml) 

```kubectl apply -f vaultwarden-pv.yaml ```

```kubectl apply -f vaultwarden-pvc.yaml ```

```kubectl apply -f vaultwarden.yaml ```

### 5.4 Cloudflare Application security 

Om te voorkomen dat iedereen zomaar toegang kan krijgen tot onze vaultwarden kunnen er allerhande veiligheidsmaatregelen getroffen worden om deze te beschermen. 
Surf naar www.cloudflare.com en navigeer vervolgens naar : Zero Trust -> Access -> Applications.

Klik vervolgens op "Add an application"

![image](https://github.com/michaelthielemans/ProjectHosting/assets/119003253/4e30e667-c683-46bb-ab70-236626fb3944)

Selecteer "Self Hosted"

![image](https://github.com/michaelthielemans/ProjectHosting/assets/119003253/d06a2f69-22b8-45ec-af29-5fbb93427d65)

Vul nu de parameters in die voor jou van toepassing zijn. Het veld session duration bepaalt hoe lang je sessie actief blijft vooraleer je opnieuw moet authentificeren. Scroll vervolgens naar beneden en druk op next. 

![image](https://github.com/michaelthielemans/ProjectHosting/assets/119003253/a567ed33-f880-4243-b9aa-e9f5b423903e)

Vervolgens kunnen we verder de policies uitwerken, vul opnieuw de details in voor de applicatie. 

![image](https://github.com/michaelthielemans/ProjectHosting/assets/119003253/6b682b41-c846-4b92-984b-7e5ca1f6f288)

Bij het rules veld kan er gefilterd worden op de volgende regels. In ons geval wordt er gefilterd op e-mail & is er multi factor autheticatie ingesteld. 

1. Any Access Service Token
2. Authentication Method
3. Common name
4. Country
5. Emails
6. Emails ending in
7. Everyone
8. External Evaluation
9. IP ranges
10. Login Methods
11. Service Token
12. Valid Certificate

Scrol vervolgens naar bedenen en klik op "Save policy"

![Naamloos](https://github.com/michaelthielemans/ProjectHosting/assets/119003253/040e7b87-c955-4f0e-862c-3eae7e61b57b)


### 5.5 Configure Vaultwarden SNMP 

Surf naar je vaultwarden hostname/admin bvb: https://vaultwarden.bloedlinks.app/admin
Klik vervolgens op "SMTP Email Settings"

![image](https://github.com/michaelthielemans/ProjectHosting/assets/119003253/8c4e94ab-cfea-4f4d-bae2-59f057c8ce15)

Vul hier je SMTP Settings in en klik onderaan het scherm op Save. 

![image](https://github.com/michaelthielemans/ProjectHosting/assets/119003253/d90be41c-20af-4cab-8295-08f29c22c7c2)

Vervolgens kan je een test email sturen om de service te testen. 

![image](https://github.com/michaelthielemans/ProjectHosting/assets/119003253/9aeec110-d6ad-4773-a559-4e466726d94b)

