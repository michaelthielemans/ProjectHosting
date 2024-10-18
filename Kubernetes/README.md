![kubernetes](../images/kubernetes.png)

## How to use kubectl from a remote machine

1. **Download and install kubectl-cli on your local machine**
2. **Copy the configuration file from the masternode to your local machine**
   - Location of the configurationfile: `~/.kube/config`
   - This file contains all the needed settings and certificates in order to make a connection with the api-server on the masternode(s)
3. **Op Linux/macOS export the system variable KUBECONFIG**:
   ```bash
   export KUBECONFIG=/path/to/kubectl/config
   ```
4. **Option without exporting the KUBECONFIG variable:**:
   ```bash
   kubectl --configfile /path/to/kubctl/config <your command>
   ```
   
