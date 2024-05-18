![kubernetes](../images/kubernetes.png)

# Test Cluster

- **Masternode beschikbaar op**: 172.24.1.81
- **Helm is geïnstalleerd op de masternode**
- **Persistent volumes zijn getest en kunnen gebruikt worden**
- **Alleen NodePort-service kan gebruikt worden** (Ingress controller nog niet geïnstalleerd)

# Manifest Files

- Plaats je manifest bestanden in de map `/Kubernetes/manifests`

# kubectl CLI Tool

kubectl is geïnstalleerd op de masternode

## Gebruik van kubectl op je lokale machine

1. **Download en installeer de kubectl-cli tool op je lokale machine**
2. **Kopieer het kubectl-configuratiebestand van de masternode naar je eigen computer**
   - Het configuratiebestand bevindt zich op: `~/.kube/config`
   - Dit configuratiebestand bevat alle benodigde instellingen en certificaten zodat je lokale kubectl verbinding kan maken met de masternode.
3. **Op Linux/macOS**:
   ```bash
   export KUBECONFIG=/path/to/kubectl/config
4. **Option without exporting the KUBECONFIG variable:**:
   ```bash
   kubectl --configfile /path/to/kubctl/config <your command>
