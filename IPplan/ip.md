# Please keep this list up to date!!

## INFRASTRUCTURE

| **Environment** | **IP** | **Machine**          | **Comment**                                    |
|-----------------|--------|----------------------|------------------------------------------------|
| infra           | 172.24.1.10  | vSphere Interface      | online                                         |
| infra           | 172.24.1.11  | vmhost esxi 01         | online                                         |
| infra           | 172.24.1.12  | vmhost esxi 02         | online                                         |
| infra           | 172.24.1.20  | xcp-server-1           | online - 8 Cores, 64GB RAM                     |
| infra           | 172.24.1.21  | xcp-server-2           | online - 8 Cores, 64GB RAM                     |
| infra           | 172.24.1.22  | xcp-ce                 | online orchestrator - virtual machine          |

## PRODUCTION

| **Environment** | **IP**      | **Machine**           | **Comment** |
| --------------- | ----------- | --------------------- | ----------- |
| prod            | 172.24.1.51 | PROD-VM-Masternode-01 | online      |
| prod            | 172.24.1.52 | PROD-VM-Masternode-02 | online      |
| prod            | 172.24.1.53 | PROD-VM-Workernode-01 | online      |
| prod            | 172.24.1.54 | PROD-VM-Workernode-02 | online      |
| prod            | 172.24.1.55 | PROD-VM-Workernode-03 | online      |
| prod            | 172.24.1.60 | KubeVip ClusterIP     | online      |
| prod            | 172.24.1.61 | Production Gateway    | online      |
| prod            | 172.24.1.62 | Production Gateway (spare)| online      |

## MANAGEMENT

| **Environment** | **IP** | **Machine**               | **Comment**                                    |
|-----------------|--------|---------------------------|------------------------------------------------|
| mgmt            | 172.24.1.71  | MGMT-VM-Masternode-01    | online                                         |
| mgmt            | 172.24.1.72  | MGMT-VM-Workernode-01    | online                                         |
| mgmt            | 172.24.1.73  | MGMT-VM-Workernode-02    | online                                         |
| mgmt            | 172.24.1.75  | MGMT-VM-Ansible          | online                                         |

## TEST

| **Environment** | **IP** | **Machine**               | **Comment**                                    |
|-----------------|--------|---------------------------|------------------------------------------------|
| test            | 172.24.1.81  | TEST-VM-Masternode-01    | online                                         |
| test            | 172.24.1.82  | TEST-VM-Workernode-01    | online                                         |
| test            | 172.24.1.83  | TEST-VM-Workernode-02    | online                                         |
| test            | 172.24.1.84  | TEMPLATE-Clusternode     | template offline                               |

## BACKUP

| **Environment** | **IP** | **Machine**               | **Comment**                                    |
|-----------------|--------|---------------------------|------------------------------------------------|
| backup          | 172.24.1.99  | BACKUP-VM-TrueNAS-01      | Primary (VSphere Cluster)                      |
| backup          | 172.24.1.100 | BACKUP-VM-TrueNAS-02      | Secondary (XCP-Cluster)                        |

## NETWORKING

| **Environment** | **IP** | **Machine**               | **Comment**                                    |
|-----------------|--------|---------------------------|------------------------------------------------|
| network         | 172.24.1.252 | PFsense gateway         | gateway + DNS forwarder                        |
