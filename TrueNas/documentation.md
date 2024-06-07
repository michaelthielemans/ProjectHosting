![image](https://github.com/michaelthielemans/ProjectHosting/assets/119003253/818125a7-a61a-43bf-9510-b625ca707e70)

Beheerder : Janssen Niels

Verantwoordelijke : Janssen Niels

## 1. Table of Contents 

| Navigation |             
| :-------------------------------------------------  |
| [1. Table of Contents](#1-table-of-contents)             |
| [2. Hardware Example](#2-hardware-example)  |
| [3. Shares](#3-shares)                     |
| [3.1 NFS Share Creation](#31-nfs-share-creation)                     |
| [3.2 Mounting an NFS share](#4-mounting-an-nfs-share)       |
| [4. Data Protection](#4-data-protection)         |
| [4.1 Scrub Tasks](#51-scrub-tasks)     |
| [4.2 S.M.A.R.T. tests](#42-s.m.a.r.t.-tests)           |
| [4.3. Cloud Sync Tasks](#43-cloud-sync-tasks)         |
| [4.4. Periodic Snapshot Tasks](#44-periodic-snapshot-tasks)         |


## 2. Hardware Example

| **Attribute**                       | **Value**                        |
|-------------------------------------|----------------------------------|
| Virtual machine name                | New Virtual Machine              |
| Folder                              | BACKUP                           |
| Cluster                             | WT Cluster                       |
| Datastore                           | NX3000                           |
| Compatibility                       | ESXi 8.0 U2 and later (VM version 21) |
| Guest OS name                       | Debian GNU/Linux 12 (64-bit)     |
| Virtualization Based Security       | Disabled                         |
| CPUs                                | 2                                |
| Memory                              | 64 GB                            |
| NICs                                | 1                                |
| NIC 1 network                       | VM Network                       |
| NIC 1 type                          | VMXNET 3                         |
| SCSI controller 1                   | VMware Paravirtual               |
| **New hard disk 1**                 |                                  |
| Capacity                            | 32 GB                            |
| Datastore                           | NX3000                           |
| Virtual device node                 | SCSI(0:0)                        |
| Mode                                | Dependent                        |
| **New hard disk 2**                 |                                  |
| Capacity                            | 3 TB                             |
| Datastore                           | NX3000                           |
| Virtual device node                 | SCSI(0:1)                        |
| Mode                                | Dependent                        |

## 3. Shares

### 3.1  NFS Share Creation

1.	Log in op je TrueNAS SCALE-webinterface.
2.	Ga naar Shares > Unix (NFS)-shares.
3.	Klik op Toevoegen om het configuratiescherm voor het toevoegen van een NFS-share te openen.
4.	Voer het pad in of gebruik het map-icoon om het dataset te lokaliseren waar je de share wilt maken.
5.	Klik op Dataset maken, geef een naam op voor het dataset en klik op Maken. Het systeem maakt het dataset geoptimaliseerd voor een NFS-share, en de datasetnaam wordt de sharenaam.
6.	Voeg eventueel een beschrijving toe om de share te identificeren.
7.	Klik op Advanced Options
  o	Maproot User: Root
8.	Klik op Networks -> Add
  o	Voeg hier het netwerk toe dat toegang mag hebben tot de NFS share  
9.	Configureer de NFS-service:
  o	Ga naar Services en klik op de NFS-schakelaar.
  o	Als je wilt dat NFS-deling direct na het opstarten van TrueNAS wordt geactiveerd, stel het dan in op Automatisch starten.


![image](https://github.com/michaelthielemans/ProjectHosting/assets/119003253/711a5146-c9c2-40b4-9937-e7e4cd87b21d)


### 3.2 Mounting an NFS share

Om de NFS share in een Ubuntu VM te mounten dient eerst het pakket “Nfs-common” geïnstalleerd te worden: 

```Sudo apt-get install nfs-common -y ```

```Sudo mkdir /mnt/testshare```

Vervolgens kan de share gemount worden 

```Sudo mount -t nfs 172.24.1.173:/mnt/Main/testshare /mnt/testshare```

## 4. Data Protection

### 4.1 Scrub Tasks

Scrubtaken in TrueNAS zijn geautomatiseerde processen die de gegevens op een ZFS-opslagpool scannen. Ze zijn bedoeld om problemen met gegevensintegriteit te identificeren, stille gegevenscorrupties veroorzaakt door tijdelijke hardware problemen op te sporen en preventieve waarschuwingen te geven voor schijfdefecten. 

![image](https://github.com/michaelthielemans/ProjectHosting/assets/119003253/e9b9279c-4a9a-444d-8b4b-500f5a942cf9)


### 4.2 S.M.A.R.T. tests

S.M.A.R.T. (Self-Monitoring, Analysis and Reporting Technology) is een industriestandaard voor het monitoren en testen van schijven. Met S.M.A.R.T. kun je schijven controleren op problemen met behulp van verschillende soorten zelftests. In TrueNAS kan je aanpassen wanneer en hoe S.M.A.R.T.-waarschuwingen worden gegeven. Als S.M.A.R.T.-bewaking een probleem met een schijf rapporteert, is er aangeraden de schijf te vervangen. 

S.M.A.R.T. tests kunnen in het volgende menu ingepland worden. 


![image](https://github.com/michaelthielemans/ProjectHosting/assets/119003253/58560d05-32e0-497c-8996-90286b7e0e71)


### 4.3 Cloud Sync Tasks

1.	Onder Cloud Sync Tasks Klik op Add.
2.	Kies de provider van cloud storage naar keuze.
3.	Log in met jouw account.
4.	Stel de gewenste frequentie in.

![image](https://github.com/michaelthielemans/ProjectHosting/assets/119003253/c92a3b78-5e1a-4033-9f27-631c6d1ac9aa)


### 4.4 Periodic Snapshot Tasks

1. Onder Periodic Snapshot Tasks -> Klik op Add.
2. Kies de dataset waarvan je snapshots wil maken, als je alle datasets wil snapshotten kies dan de root dataset en vink recursive aan.
3. Kies de frequentie en hoelang je wil dat de snapshots bewaard worden.
   
![image](https://github.com/michaelthielemans/ProjectHosting/assets/119003253/d1d896a9-48c0-4846-b453-77827d134bf0)

![image](https://github.com/michaelthielemans/ProjectHosting/assets/119003253/589f29b4-ed90-4c22-b274-21822bc67368)

