![image](https://github.com/michaelthielemans/ProjectHosting/assets/119003253/818125a7-a61a-43bf-9510-b625ca707e70)

## 1. Table of Contents 

| 1.  |     | Table of contents             |
| --- | --- | ----------------------------- |
| 2.  |     | Minimum Hardware Requirements |
| 4.  |     | Download TrueNAS Scale        |
| 5.  |     | Install TrueNAS Scale         |


## Minimum Hardware Requirements
| Processor                                   | Memory      | Boot Device           | Storage                                                 |
| ------------------------------------------- | ----------- | --------------------- | ------------------------------------------------------- |
| 2-Core Intel 64-Bit or AMD x86_64 processor | 8 GB Memory | 16 GB SSD boot device | Two identically-sized devices for a single storage pool |

## 2. Procedure

1. Download TrueNAS Scale (ISO)
2. Open VSphere of de hypervisor die je ter beschikking hebt
3. Upload de ISO 
4. Maak een nieuw virtueel machine aan met de specificaties aangegeven in hoofdstuk "Virtual Machine Overview" of een variatie hierop. 
5. Installeer TrueNAS Scale 

## 3. Download TrueNAS scale 

Ga naar de volgende link en download de laatste versie van TrueNAS scale 

https://www.truenas.com/download-truenas-scale/

## 4. Install TrueNAS scale

### 4.1 Virtual Machine overview

| Virtual machine name          | New Virtual Machine                   |
| ----------------------------- | ------------------------------------- |
| Folder                        | BACKUP                                |
| Cluster                       | WT Cluster                            |
| Datastore                     | NX3000                                |
| Compatibility                 | ESXi 8.0 U2 and later (VM version 21) |
| Guest OS name                 | Debian GNU/Linux 12 (64-bit)          |
| Virtualization Based Security | Disabled                              |
| CPUs                          | 2                                     |
| Memory                        | 64 GB                                 |
| NICs                          | 1                                     |
| NIC 1 network                 | VM Network                            |
| NIC 1 type                    | VMXNET 3                              |
| SCSI controller 1             | VMware Paravirtual                    |
|                               |                                       |
| **New hard disk 1**           |                                       |
| Capacity                      | 32 GB                                 |
| Datastore                     | NX3000                                |
| Virtual device node           | SCSI(0:0)                             |
| Mode                          | Dependent                             |
|                               |                                       |
| **New hard disk 2**           |                                       |
| Capacity                      | 3 TB                                  |
| Datastore                     | NX3000                                |
| Virtual device node           | SCSI(0:1)                             |
| Mode                          | Dependent                             |


![image](https://github.com/michaelthielemans/ProjectHosting/assets/119003253/e9d9d57d-62ad-4475-803e-f7e37d1ffe69)

![image](https://github.com/michaelthielemans/ProjectHosting/assets/119003253/1ce9bdea-d17c-442d-af77-7d9a7ae0952c)

![image](https://github.com/michaelthielemans/ProjectHosting/assets/119003253/3a69f0ee-df1a-40e3-90d9-03709a36bb90)

![image](https://github.com/michaelthielemans/ProjectHosting/assets/119003253/1e19fb93-0850-4962-b4eb-d90bb6077367)

![image](https://github.com/michaelthielemans/ProjectHosting/assets/119003253/3f26fae0-4bb0-40fb-a8c4-e6adefb2e487)



![image](https://github.com/michaelthielemans/ProjectHosting/assets/119003253/cd37a133-23eb-48b5-b23e-02dadc3af485)

Herstart het virtueel machine nu.

![image](https://github.com/michaelthielemans/ProjectHosting/assets/119003253/9142902c-181a-4850-a590-30626c7e4f34)

Na het herstarten zal TrueNAS nu beschikbaar zijn via de webinterface verbonden aan het ip adres aangegeven op het virtueel machine. 

![image](https://github.com/michaelthielemans/ProjectHosting/assets/119003253/37b6e2eb-36e7-4318-9608-58aa0b8b23c8)

