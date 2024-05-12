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

## Download TrueNAS scale 

Ga naar de volgende link en download de laatste versie van TrueNAS scale 

https://www.truenas.com/download-truenas-scale/

## Install TrueNAS scale

### Virtual Machine overview

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

![[Pasted image 20240512143819.png]]


