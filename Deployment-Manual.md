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

## 5.2 Creation of NFS share

## 5.3 Cloudflare DNS + Deployment

## 5.4 Prepare Helm 

## 5.5 Generate database credentials Vaultwarden

## 5.6 Complete values.yaml

## 5.7 Deploy Helm chart

## 5.8 Test deployment 

