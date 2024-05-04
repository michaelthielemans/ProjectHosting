# VMWARE VSphere info
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
workernode - masternode - truenas - michael
#### For example:
- test-vm-michael-01
- prod-vm-workernode-01
- test-vm-masternode-01
- test-template-masternode


## IP-ranges and conventions
Subnet = 172.24.1.0/24

Static range for PROD VMs:
- 172.24.1.10-100
Static range for MGMT VMs:
- 172.24.1.??-??
Static range for TEST VMs:
- 172.24.1.200-254


For test VMs you can leave it dhcp if you want.
- By default dhcp is enabled on newly created test vm's






