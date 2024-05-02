# Installing ansible AWX with HELM
read : [install AWX operator](https://github.com/ansible/awx-operator/blob/devel/.helm/starter/README.md)

AWX can only be installed on a kubernetes cluster, for existing clusters a HELM chart can be used.
This kind of AWX installation is called 'AWX-operator'

It has its own namespace in the cluster, with multiple pods.

```
$ helm repo add awx-operator https://ansible.github.io/awx-operator/
"awx-operator" has been added to your repositories

$ helm repo update
Hang tight while we grab the latest from your chart repositories...
...Successfully got an update from the "awx-operator" chart repository
Update Complete. ⎈Happy Helming!⎈

$ helm search repo awx-operator
NAME                            CHART VERSION   APP VERSION     DESCRIPTION
awx-operator/awx-operator       0.17.1          0.17.1          A Helm chart for the AWX Operator

$ helm install -n awx --create-namespace my-awx-operator awx-operator/awx-operator
NAME: my-awx-operator
LAST DEPLOYED: Thu Feb 17 22:09:05 2022
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
Helm Chart 0.17.1
```
