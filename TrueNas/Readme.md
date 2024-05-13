![image](https://github.com/michaelthielemans/ProjectHosting/assets/119003253/818125a7-a61a-43bf-9510-b625ca707e70)

Beheerder : Janssen Niels

Verantwoordelijke : Janssen Niels

## 1. Table of Contents 

| Navigation |             
| :-------------------------------------------------  |
| [1. Table of Contents](#1-table-of-contents)             |
| [2. IP addressing](#2-ip-addressing)  |
| [3. Shares](#3-shares)                     |
| [4. Hardware Specifications](#4-hardware-specifications)       |
| [5. Dataset Topology](#5-dataset-topology)         |
| [6. Data Protection](#6-data-protection)     |
| [7. Manual](#52-manual)           |
| [7.1 Mounting NFS share Linux](#6-mounting-nfs-share-linux)         |
| [7.2 Mounting NFS share Kubernetes](#6-mounting-nfs-share-kubernetes)         |
| [7.3 SFTP via Filezilla](#6-sftp-via-filezilla)         |

| Rol               | Naam          |
| ----------------- | ------------- |
| Beheerder         | Janssen Niels |
| Verantwoordelijke | Janssen Niels |
## 2. IP addressing

| Rol       | IP adres     | Cluster       |
| --------- | ------------ | ------------- |
| Primary   | 172.24.1.99  | VSphere       |
| Secondary | 172.24.1.100 | Xen Orchestra |
## 3. Shares 

| Rol         | Username     | NFS Share | Mount path                   | SFTP Share |     |
| ----------- | ------------ | --------- | ---------------------------- | ---------- | --- |
| Persoonlijk | dverbeek     | ✅         | /mnt/Main/Management/Dieter  | ✅          |     |
| Persoonlijk | jrzeczkowski | ✅         | /mnt/Main/Management/Jakub   | ✅          |     |
| Persoonlijk | mthielemans  | ✅         | /mnt/Main/Management/Michael | ✅          |     |
| Persoonlijk | njanssen     | ✅         | /mnt/Main/Management/Wim     | ✅          |     |
| Persoonlijk | wheyns       | ✅         | /mnt/Main/Management/Niels   | ✅          |     |
| Apps        | /            | ✅         | /mnt/Main/Apps               | ❌          |     |
| Klant       |              | ✅         |                              | ✅          |     |
| Klant       |              | ✅         |                              | ✅          |     |
| Klant       |              | ✅         |                              | ✅          |     |

## 4. Hardware Specifications 

| Rol       | Installation | Storage | RAM   | CPU | Version |
| --------- | ------------ | ------- | ----- | --- | ------- |
| Primary   | 32gb         | 2TB     | 64 GB | 2   | 24.04   |
| Secondary | 32gb         | 2TB     | 64 GB | 2   | 24.04   |

## 5. Dataset topology

![image](https://github.com/michaelthielemans/ProjectHosting/assets/119003253/525781df-08aa-43b2-ba4d-ed0801987cd9)


## 6. Data Protection 

Alle storage is beschermd door middel van Raid 5 hardware raid. 

Daarbovenop zijn er de volgende data protection voorzorgsmaatregelen genomen.  

![image](https://github.com/michaelthielemans/ProjectHosting/assets/119003253/9bfc0883-4625-4ae3-ad49-a384650e0e42)

## 7. Manual

### 7.1 Mounting NFS share Linux 

1. Install nfs-common package
2. maak een directory in de /mnt waar je de NFS share will mounten
3. Mount nfs share (pas het commando aan waar nodig)

```sudo apt-get install nfs-common -y```

```sudo mkdir /mnt/Apps```

```sudo chmod 755 /mnt/Apps```

```sudo mount -t nfs 172.24.1.99:/mnt/Main/Apps /mnt/Apps```

### 7.2 Mounting NFS share Kubernetes

1. Maak file nfs-pv.yaml (zie deze folder)
2. Pas het path aan naar wat voor jou van toepassing is. 
3. Maak file nfs-pvc.yaml (zie deze folder)
4. Pas de storage aan naar wat voor jou van toepassing is. 
5. Mount de persistent volume & persistent volume claim

### 7.3 SFTP via Filezilla

![image](https://github.com/michaelthielemans/ProjectHosting/assets/119003253/f66a3d27-365f-4d26-8b5f-bbf87e516f33)
