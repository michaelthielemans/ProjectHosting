![image](https://github.com/michaelthielemans/ProjectHosting/assets/119003253/222393f8-3d0b-43df-86a5-85dd29dfcb93)

## 1. Table of Contents 

| Navigation |             
| :-------------------------------------------------  |
| [1. Table of Contents](#1-table-of-contents)             |
| [2. Overview](#2-overview)  |
| [3. Procedure](#3-procedure)                     |
| [4. Register domain name @ Cloudflare](#4-download-truenas-scale)       |
| [5. Set up a cloudflare zero trust tunnel](#5-install-truenas-scale)         |
| [5.1 Virtual Machine overview](#51-virtual-machine-overview)     |
| [5.2 TrueNAS Installer](#52-truenas-installer)           |
| [6. TrueNAS WebInterface](#6-truenas-webinterface)         |

## 2. Overview

![image](https://github.com/michaelthielemans/ProjectHosting/assets/119003253/53a2494c-0b1d-4540-b9fa-0c5e137f2347)
(cloudflare.com) 

## 3. Procedure

1. Register domain name @ Cloudflare
2. Set up a cloudflare zero trust tunnel
3. Link the cloudflare zero trust tunnel to the service you wish to host
4. Test the hosted service

## 4. Register domain name @ Cloudflare

Surf naar www.cloudflare.com, maak hier een account aan en koop vervolgens een domein naam. 

![image](https://github.com/michaelthielemans/ProjectHosting/assets/119003253/e3c73f9e-11de-4b5a-a854-4e88ceeafeb6)

## 5. Set up a cloudflare zero trust tunnel

Op de cloudflare website, klik in de linker navigatiebalk op Zero Trust -> Networks -> Tunnels -> Create a tunnel.

![image](https://github.com/michaelthielemans/ProjectHosting/assets/119003253/733fa707-c459-41fd-816c-82fb2a347abb)

Onder het menu "Select your connector" selecteer "Cloudflared" en druk op next.

![image](https://github.com/michaelthielemans/ProjectHosting/assets/119003253/003ed399-d26e-4252-887a-2b7a3e0faeb8)

Geef je tunnel een duidelijke naam en klik op "Save tunnel".

![image](https://github.com/michaelthielemans/ProjectHosting/assets/119003253/9fba323a-1f26-4f3d-b16d-af33f38aa822)

Vervolgens moet er Cloudflared geïnstalleerd worden op de master node(s) kies de juiste environment. In ons geval is dit Debian omdat Ubuntu daarop gebaseerd is. 
Kopieer de linker code block en voer dit uit op de master node. 

![image](https://github.com/michaelthielemans/ProjectHosting/assets/119003253/ad0c5f8c-9895-4f94-81ec-8126fa1184d2)

![image](https://github.com/michaelthielemans/ProjectHosting/assets/119003253/8725716d-c116-4f49-90e2-4472de8d6e94)

Log nu in via de CLI op cloudflare met het commando "cloudflared login".
kopiëer de link en plak deze in je browser en klik op Authorize om dit te voltooien. 

![image](https://github.com/michaelthielemans/ProjectHosting/assets/119003253/97c087cc-bdd6-4b82-a647-651ba3e7abb1)

![image](https://github.com/michaelthielemans/ProjectHosting/assets/119003253/5e86b280-046b-459c-ada9-9136f4f9c98b)

Met het "cloudflared tunnel list" commando kan je nu verifiëren dat je login werkt. Hier kan je ook meteen de tunnel zien die we daarnet via de webinterface gemaakt hebben. 

![image](https://github.com/michaelthielemans/ProjectHosting/assets/119003253/39be351f-2c99-40c5-848b-6f51934f2d0f)

![image](https://github.com/michaelthielemans/ProjectHosting/assets/119003253/c4aa73fe-5cd0-491d-a7b9-026638288271)

Vervolgens moet het volgende aangepast worden in de [cloudflare manifest file](/Cloudflare/cloudflare-deployment.yaml):

1. De naam van de tunnel = <Tunnel ID>
2. De naam van de tunnel credentials file = <Tunnel ID>.json
3. De hostname(s) waarop we de service(s) willen exposen 
4. Welke service(s) we willen exposen op onze cluster
5. De tunnel token

Voer het commando cloudflared tunnel list command uit en kopiëer het <ID> van de tunnel die je daarnet aangemaakt hebt. 
In de volgende screenshot wordt stap 1 t.e.m. 4 behandeld. 

![image](https://github.com/michaelthielemans/ProjectHosting/assets/119003253/62b60d50-1550-48cb-83af-61e00660e140)

![image](https://github.com/michaelthielemans/ProjectHosting/assets/119003253/354cb734-5ee9-4b7f-869f-db5d191fbc46)

Nu moet alleen nog de tunnel token toegevoegd worden aan de cloudflare manifest file. 
Om de tunnel token te verkrijgen moeten we het volgende commando uitvoeren: 

cloudflared tunnel token <Tunnel ID>

![image](https://github.com/michaelthielemans/ProjectHosting/assets/119003253/83e5faf0-5243-4ff6-9eed-e7b72b79393c)

Vervolgens plakken we de <Tunnel Token> onder het Tunnel Token veld.

![image](https://github.com/michaelthielemans/ProjectHosting/assets/119003253/a60c54ff-84ba-4054-ab1d-3cac5c8d3632)

Met het commando : kubectl logs -n <namespace> <cloudflare-pod> kunnen we zien als de deployment naar behoren werkt. 
onderaan de screenshot zien we als de tunnel verbinding correct geregistreerd is. 

![image](https://github.com/michaelthielemans/ProjectHosting/assets/119003253/5e273182-6923-4f05-9d0f-bcecf74d5327)

 ## 6. Link the cloudflare zero trust tunnel to the service you wish to host

 Navigeer op de cloudflare website naar Zero Trust -> Network -> Tunnels -> to-thomasmore -> Configure

 Klik nu op "Public Hostname" en vervolgens op "Add a public hostname"

![image](https://github.com/michaelthielemans/ProjectHosting/assets/119003253/0ebdfa21-e326-42ea-8095-4512947ff417)

