![image](https://github.com/michaelthielemans/ProjectHosting/assets/119003253/f1c65477-05bf-4553-9095-869d9e4e2f49)

Beheerder : Janssen Niels

Verantwoordelijke : Janssen Niels

## 1. Table of Contents 

| Navigation |             
| :-------------------------------------------------  |
| [1. Table of Contents](#1-table-of-contents)             |
| [2. Overview](#2-overview)  |
| [3. Prerequisites](#3-procedure)                     |
| [4. Procedure](#4-hardware-specifications)       |
| [5. Execution](#5-execution)         |
| [6. Testing](#6-testing)      |

| Rol               | Naam          |
| ----------------- | ------------- |
| Beheerder         | Janssen Niels |
| Verantwoordelijke | Janssen Niels |


## 2. Overview

Adminer is een lichtgewicht databasebeheer tool die gebruikt wordt om databases te beheren via een webinterface. 
Wij stellen optioneel adminer beschikbaar aan de klant. Hij kan adminer raadplegen via [adminer.bloedlinks.app](http://adminer.bloedlinks.app) en met zijn database credentials hierop inloggen. 

## 3. Prerequisites

1. [Cloudflare zero trust tunnel](/Cloudflare/Readme.md)
2. Namespace ns-klanten

## 4. Procedure

1. Pas de [Cloudflare deployment](/Cloudflare/namespace-klanten/cloudflare/cloudflare-klanten.yaml) aan waar nodig.
2. Pas de [Adminer deployment](adminer.yaml) aan waar nodig
3. Voer de deployment uit

## 5. Execution

Voer nu het volgende commando uit om de adminer deployment te ontplooien.

```kubectl apply -f adminer.yaml```

## 6. Testing

Voer het volgende commando uit om te controleren dat de pod correct gestart is. 

```kubectl get pods -n ns-klanten```

![image](https://github.com/michaelthielemans/ProjectHosting/assets/119003253/d4997d09-a41f-4d48-b6cc-f8339de06c8e)

Surf naar de adminer domain name die gekoppeld is aan cloudflare om de gehele keten te testen. 

![image](https://github.com/michaelthielemans/ProjectHosting/assets/119003253/6985a696-7613-4bca-99c8-4b17fa8dffda)
