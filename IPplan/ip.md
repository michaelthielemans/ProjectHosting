# Please keep this list up to date !!

|**environment**| **ip** | **machine** | **comment** |
|---|---|---|---|
| INFRASTRUCTURE |
| infra | 172.24.1.10 | vSphere Interface | online |
| infra | 172.24.1.11 | vmhost esxi 01 | online |
| infra | 172.24.1.12 | vhmhost esxi 02 | online |
| infra | 172.24.1.20 | xcp-server-1| online-  8 Cores, 64GB ram |
| infra | 172.24.1.21 | xcp-server-2 | online- 8 Cores, 64GB ram|
| infra | 172.24.1.22 | xcp-ce | online orchestrator- virtual machine |
| PRODUCTION |
| prod | 172.24.1.51 | PROD-VM-Masternode-01 | |
| prod | 172.24.1.52 | PROD-VM-Masternode-02 | |
| prod | 172.24.1.53 | PROD-VM-Workernode-01 | |
| prod | 172.24.1.54 | PROD-VM-Workernode-02 | |
| prod | 172.24.1.55 | PROD-VM-Workernode-03 | |
| MANAGEMENT |
| mgmt | 172.24.1.71 | MGMT-VM-Masternode-01 | |
| mgmt | 172.24.1.72 | MGMT-VM-Workernode-01 | |
| mgmt | 172.24.1.73 | MGMT-VM-Workernode-02 | |
| TEST |
| test | 172.24.1.81 | TEST-VM-Masternode-01 | online |
| test | 172.24.1.82 | TEST-VM-Workernode-01 | online |
| test | 172.24.1.83 | TEST-VM-Workernode-02 | online |
| test | 172.24.1.84 | TEMPLATE-Clusternoe | template offline |
| BACKUP |
| backup | 172.24.1.99 | BACKUP-VM-TrueNAS-01 | Primary (VSphere Cluster) |
| backup | 172.24.1.100 | BACKUP-VM-TrueNAS-02 | Secondary (XCP-Cluster) |
| NETWORKING |
| network | 172.24.1.252 | PFsense gateway| gateway + dns forwarder |
