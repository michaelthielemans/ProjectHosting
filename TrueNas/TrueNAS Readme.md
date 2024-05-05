![image](https://github.com/michaelthielemans/ProjectHosting/assets/119003253/818125a7-a61a-43bf-9510-b625ca707e70)

Beheerder : Janssen Niels

Verantwoordelijke : Janssen Niels

| Rol               | Naam          |
| ----------------- | ------------- |
| Beheerder         | Janssen Niels |
| Verantwoordelijke | Janssen Niels |
## IP adressen

| Rol       | IP adres     | Cluster       |
| --------- | ------------ | ------------- |
| Primary   | 172.24.1.99  | VSphere       |
| Secondary | 172.24.1.100 | Xen Orchestra |
## Credentials 

| Username    | NFS Share | Mount path                   | SFTP Share |
| ----------- | --------- | ---------------------------- | ---------- |
| dverbeek    | ✅         | /mnt/Main/Management/Dieter  | ✅          |
| jzeczkowski | ✅         | /mnt/Main/Management/Jakub   | ✅          |
| mthielemans | ✅         | /mnt/Main/Management/Michael | ✅          |
| njanssen    | ✅         | /mnt/Main/Management/Wim     | ✅          |
| wheyns      | ✅         | /mnt/Main/Management/Niels   | ✅          |

## Specifications 

| Rol       | Installation | Storage | RAM   | CPU | Version |
| --------- | ------------ | ------- | ----- | --- | ------- |
| Primary   | 32gb         | 2TB     | 64 GB | 2   | 24.04   |
| Secondary | 32gb         | 2TB     | 64 GB | 2   | 24.04   |

## Dataset topologie

![image](https://github.com/michaelthielemans/ProjectHosting/assets/119003253/525781df-08aa-43b2-ba4d-ed0801987cd9)


## Data Protection 

Alle storage is beschermd door middel van Raid 5 hardware raid. 

Daarbovenop zijn er de volgende data protection voorzorgsmaatregelen genomen.  

![image](https://github.com/michaelthielemans/ProjectHosting/assets/119003253/9bfc0883-4625-4ae3-ad49-a384650e0e42)

## Handleiding

### Mounting NFS share Linux 

1. Install nfs-common package
2. Mount nfs share

`Sudo apt-get install nfs-common -y`
`Sudo mount -t nfs 172.24.1.173:/mnt/Main/testshare /var/backups`

### Mounting NFS share Kubernetes

1. Maak file nfs-pv.yaml
2. Pas het path aan naar wat voor jou van toepassing is. 
3. Maak file nfs-pvc.yaml 
4. Pas de storage aan naar wat voor jou van toepassing is. 
5. Mount de persistent volume & persistent volume claim

###### nfs-pvc.yaml
'''apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: nfs-pvc
spec:
  storageClassName: nfs
  accessModes:
    - ReadWriteMany
  resources:
    requests:
      storage: 1Gi'''
###### nfs-pv.yaml
'''apiVersion: v1
kind: PersistentVolume
metadata:
  name: nfs-pv
spec:
  capacity:
    storage: 1Gi
  volumeMode: Filesystem
  accessModes:
    - ReadWriteMany
  persistentVolumeReclaimPolicy: Recycle
  storageClassName: nfs
  mountOptions:
    - hard
    - nfsvers=4.1
  nfs:
    path: /mnt/Main/Management/Niels # pas dit aan naar jouw path 
    server: 172.24.1.99'''
### SFTP via Filezilla

