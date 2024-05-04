# VMWARE VSphere info
- [vSphere login](https://172.24.1.10)
- [how to upload iso files](#location-of-image-files)
- [Create VM](CreateVM.md)
- [Download VMWare REmote Client](https://customerconnect.vmware.com/en/downloads/details?downloadGroup=VMRC1205&productId=614)

# Naming convention VM's
### environment-type-function-number
#### Environment:
test - mgmt - prod
#### type:
vm - template
#### Function/owner:
workernode - masternode - truenas - michael - .......
#### For example:
- test-vm-michael-01
- prod-vm-workernode-01
- test-vm-masternode-01
- test-template-masternode


## IP-ranges and conventions
Subnet = 172.24.1.0/24
|start address | end address | assigned to |
|---|---|---|
| 172.24.1.1 | 172.24.1.50 | 3WerkTraject |
| 172.24.1.51 | 172.24.1.70 | Production net |
| 172.24.1.71 | 172.24.1.80 | Mgmt net |
| 172.24.1.81 | 172.24.1.100 | Test net |
| 172.24.1.101 | 172.24.1.199 | dhcp-scope |
| 172.24.1.200 | 172.24.1.254 | spare |

For test VMs you can leave it dhcp if you want.
- By default dhcp is enabled on newly created test vm's






