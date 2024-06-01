Hier is een `troubleshoot.md` bestand dat je kunt gebruiken om SMTP-connectiviteit vanuit een pod te testen, evenals verschillende commando's om de status van je pods, replicasets en netwerkconnectiviteit te controleren.

```markdown
# Troubleshooting SMTP Connectie vanuit een Pod

Dit document biedt stapsgewijze instructies om SMTP-connectiviteit te testen vanuit een pod en om verschillende controles uit te voeren op pods, replicasets, en netwerkconnectiviteit.

## Stap 1: Controleer de Status van de Pods

Gebruik de volgende commando's om de status van de pods in de `monitoring` namespace te controleren.

### Lijst alle Pods

```bash
kubectl get pods -n monitoring
```

### Gedetailleerde Informatie over een Specifieke Pod

Vervang `<pod-name>` door de naam van de pod die je wilt onderzoeken.

```bash
kubectl describe pod <pod-name> -n monitoring
```

## Stap 2: Controleer de ReplicaSets

Gebruik de volgende commando's om de status van de replicasets in de `monitoring` namespace te controleren.

### Lijst alle ReplicaSets

```bash
kubectl get rs -n monitoring
```

### Gedetailleerde Informatie over een Specifieke ReplicaSet

Vervang `<replicaset-name>` door de naam van de replicaset die je wilt onderzoeken.

```bash
kubectl describe rs <replicaset-name> -n monitoring
```

## Stap 3: Test Netwerkconnectiviteit vanuit een Pod

Gebruik een tijdelijke testpod om netwerkconnectiviteit te controleren en verbinding te maken met de SMTP-server.

### Maak een Test Pod

Maak een `network-test.yaml` bestand met de volgende inhoud:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: network-test
  namespace: monitoring
spec:
  containers:
  - name: network-tools
    image: nicolaka/netshoot
    command: ["/bin/sh"]
    stdin: true
    tty: true
  securityContext:
    runAsUser: 0
    runAsGroup: 0
    fsGroup: 0
```

Maak de pod:

```bash
kubectl apply -f network-test.yaml
```

### Toegang tot de Test Pod

```bash
kubectl exec -it network-test -n monitoring -- /bin/sh
```

### Test SMTP Connectiviteit met `curl`

Gebruik `curl` om de verbinding met de SMTP-server te testen.

```sh
curl -4 -v telnet://smtp.gmail.com:587
```

### Test SMTP Connectiviteit met `telnet`

Als `telnet` beschikbaar is, kun je het volgende commando gebruiken om verbinding te maken met de SMTP-server:

```sh
telnet smtp.gmail.com 587
```

### Handmatige SMTP Authentificatie met `telnet`

1. **Verbind met de SMTP Server**:

   ```sh
   telnet smtp.gmail.com 587
   ```

2. **Voer de SMTP Handshake uit**:

   ```sh
   EHLO smtp.gmail.com
   AUTH LOGIN
   ```

3. **Gebruik Base64 Encodering voor Authenticatie**:

   Encodeer je gebruikersnaam en wachtwoord in Base64.

   ```sh
   echo -n 'linuxprojecthosting@gmail.com' | base64
   echo -n 'in te vullen' | base64
   ```

   Gebruik de gecodeerde waarden in de `telnet` sessie.

### Controleer de Ingesteld Environment Variables in de Grafana Pod

```sh
kubectl exec -it <grafana-pod-name> -n monitoring -- env | grep GF_SMTP
```

Vervang `<grafana-pod-name>` door de naam van je Grafana pod.

## Stap 4: Verwijder de Test Pod

Als je klaar bent met testen, kun je de test pod verwijderen.

```bash
kubectl delete pod network-test -n monitoring
```

## Veelvoorkomende Problemen en Oplossingen

- **SMTP Verbinding Fout**: Controleer of er firewallregels of beveiligingsgroepen zijn die uitgaand verkeer op poort 587 blokkeren.
- **Pod Netwerkconnectiviteit**: Zorg ervoor dat er geen netwerkpolicies zijn die uitgaand verkeer vanuit de pod blokkeren.

## Extra Hulpbronnen

- [Prometheus Documentation](https://prometheus.io/docs/introduction/overview/)
- [Grafana Documentation](https://grafana.com/docs/grafana/latest/)
- [Kube-Prometheus Stack](https://github.com/prometheus-operator/kube-prometheus)

---

Door deze stappen te volgen, kun je effectief SMTP-connectiviteit vanuit een pod testen en verschillende aspecten van je Kubernetes cluster controleren. Als je tegen problemen aanloopt, gebruik dan de bovenstaande commando's en richtlijnen om het probleem te diagnosticeren en op te lossen.
```
