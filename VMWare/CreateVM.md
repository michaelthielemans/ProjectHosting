Check notes on each template for detailed info !!


# Settings for creating a new VM


### compatibility :
- SelectVmVersionPage.vmx-21
### scsi controller:
- scsi controller: VMWare Paravirtual   -> best performance
- scsi bus sharing: none
### network
- adapter type: VMXNET 3

### New dvd drive:
- Datastore ISO file
- select 'connect at power on'
- dvd media: browse
  -   -> local DS on ESXi -> iso -> ....





# Templates

A templates can be exported as OVF file format. Is a format that comprises all settings, disks,... of a vm. 



### For creating test VMs use the template:
- WT Datacenter
  - 2WT
    - Template-Test-VM-Baseline
      -> right click -> 'new VM from this template'

  
### For creating a VM for cluster Node:
  Template KUBE-Node
cluster-node template

