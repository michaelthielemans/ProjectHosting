# Design considerations hyperVisor

## Kubernetes production-cluster nodes specifications:

**02 masternodes in HA**
- CPU : 4 cores
- RAM : 8GB
- storage: 1 Disk 100GB

**minimum 03 Worker Nodes**
- CPU : 8 cores
- RAM : 16GB ( depending on total physical memory)
- storage: 1 Disk 100GB

## Kubernetes test-cluster nodes specifications:

**01 masternodes in HA**
- CPU : 4 cores
- RAM : 8GB
- storage: 1 Disk 100GB

**minimum 02 Worker Nodes**
- CPU : 4 cores
- RAM : 16GB ( depending on total physical memory)
- storage: 1 Disk 100GB

## Kubernetes MGMT-cluster nodes specifications:

**01 masternodes in HA**
- CPU : 4 cores
- RAM : 8GB
- storage: 1 Disk 100GB

**minimum 02 Worker Nodes**
- CPU : 4 cores
- RAM : 16GB ( depending on total physical memory)
- storage: 1 Disk 100GB

## Truenas VM  specifications
- CPU : 8 cores
- RAM : 32 GB
- Storage : a lot

## 05 test vm's with baseline debian machine for each team member
- CPU : 2 Cores
- RAM : 8 GB
- Storage : 100GB

## Ansible (+puppet) VM specifications needed , install ansible inside the mgmt cluster??
- CPU : 4 cores
- RAM : 8GB
- Storage : 250GB 
