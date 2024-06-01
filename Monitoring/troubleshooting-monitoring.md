# Troubleshooting voor Grafana en Prometheus in Kubernetes

Dit document biedt een uitgebreide gids voor het oplossen van problemen met Grafana en Prometheus in een Kubernetes-clusteromgeving. Hierin worden verschillende aspecten behandeld zoals het controleren van podstatus, het testen van netwerkconnectiviteit en het oplossen van specifieke problemen.

## Controleer de Status van de Pods

Gebruik de volgende commando's om de status van de pods in de `monitoring` namespace te controleren.

### Lijst alle Pods

```bash
kubectl get pods -n monitoring
```
![image](https://github.com/michaelthielemans/ProjectHosting/assets/119010746/78b064ff-09c6-4673-b660-1a063e529121)

### Gedetailleerde Informatie over een Specifieke Pod

Vervang `<pod-name>` door de naam van de pod die je wilt onderzoeken.

```bash
kubectl describe pod <pod-name> -n monitoring
```

## Controleer de ReplicaSets

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

## Test Netwerkconnectiviteit vanuit een Pod

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

### Pas de Test Pod toe

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
Voorbeeld op production pod:
![image](https://github.com/michaelthielemans/ProjectHosting/assets/119010746/844efdbc-5312-4781-b10a-6d5bf728fcc7)


### Test SMTP Connectiviteit met `telnet`

Als `telnet` beschikbaar is, kun je het volgende commando gebruiken om verbinding te maken met de SMTP-server:

```sh
telnet smtp.gmail.com 587
```


### Controleer de Ingesteld Environment Variables in de Grafana Pod

```sh
kubectl exec -it <grafana-pod-name> -n monitoring -- env | grep GF_SMTP
```

Vervang `<grafana-pod-name>` door de naam van je Grafana pod.

### Controleer Firewall en Beveiligingsgroepen

Controleer of de netwerkpolicies, firewalls en beveiligingsgroepen van je Kubernetes-cluster uitgaand verkeer op poort 587 naar `smtp.gmail.com` toestaan.

### Controleer Network Policies

### Lijst alle Network Policies

```bash
kubectl get networkpolicies -n monitoring
```

### Gedetailleerde Informatie over een Specifieke Network Policy

Vervang `<networkpolicy-name>` door de naam van de network policy die je wilt onderzoeken.

```bash
kubectl describe networkpolicy <networkpolicy-name> -n monitoring
```

### Logs Controleren

Controleer de logs van de Grafana pod voor gedetailleerde foutmeldingen.

```sh
kubectl logs <grafana-pod-name> -n monitoring
```

Controleer de logs van de Prometheus pod voor gedetailleerde foutmeldingen.

```sh
kubectl logs <prometheus-pod-name> -n monitoring
```

## Veelvoorkomende Problemen en Oplossingen

### SMTP Verbinding Fout

1. **Controleer de Firewallregels en Beveiligingsgroepen**:
   Zorg ervoor dat uitgaand verkeer op poort 587 is toegestaan.

2. **Controleer de Network Policies**:
   Zorg ervoor dat er geen restrictieve network policies zijn die uitgaand verkeer vanuit de pod blokkeren.

3. **Controleer de SMTP Configuratie**:
   Zorg ervoor dat de SMTP-instellingen correct zijn geconfigureerd in de `custom-values-ha.yaml` en dat deze zijn toegepast.

### Pods Starten Niet

1. **Controleer de Pod Logs**:
   Gebruik `kubectl logs <pod-name> -n monitoring` om de logs te controleren.

2. **Controleer de Resource Requests en Limits**:
   Zorg ervoor dat er voldoende resources beschikbaar zijn in het cluster om de pods te starten.

3. **Controleer de Events**:
   Gebruik `kubectl describe pod <pod-name> -n monitoring` om events te controleren die mogelijk de oorzaak zijn van het probleem.

### Grafana Dashboards Laden Niet Correct

1. **Controleer de Data Source Configuratie**:
   Zorg ervoor dat de Prometheus data source correct is geconfigureerd in Grafana.

2. **Controleer de Grafana Logs**:
   Gebruik `kubectl logs <grafana-pod-name> -n monitoring` om de logs te controleren op foutmeldingen.

### Extra Hulpbronnen

- [Prometheus Documentation](https://prometheus.io/docs/introduction/overview/)
- [Grafana Documentation](https://grafana.com/docs/grafana/latest/)
- [Kube-Prometheus Stack](https://github.com/prometheus-operator/kube-prometheus)

