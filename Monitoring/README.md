
## Monitoring Installatie met Prometheus en Grafana

Dit document omvat de verschillende stappen voor de installatie en configuratie van monitoring van een Kubernetes cluster gebruik makend van Prometheus en Grafana.

### Prerequisites

1. Kubernetes cluster met minstens 1 master node en 2 worker nodes.
2. Helm geïnstalleerd.
3. Toegang tot de Kubernetes cluster met `kubectl`.

### Stap 1: Install Helm Repositories

Voeg de nodige Helm repositories toe voor Prometheus en Grafana.

```bash
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update
```

### Stap 2: Maak een Namespace voor Monitoring

Maak een namespace enkel voor monitoring componenten.

```bash
kubectl create namespace monitoring
```

### Stap 3: Installeer Prometheus Operator

Deploy de Prometheus Operator met Helm.

```bash
helm install prometheus-operator prometheus-community/kube-prometheus-stack --namespace monitoring
```

### Stap 4: Configureer Prometheus en Grafana voor Hoge Beschikbaarheid

Maak een `custom-values-ha.yaml` bestand met de volgende inhoud:

```yaml
prometheus:
  prometheusSpec:
    replicas: 1
    retention: 10d

grafana:
  replicas: 1
```

Installeer of upgrade de Prometheus Operator met de aangepaste configuratie:

```bash
helm upgrade --install prometheus-operator prometheus-community/kube-prometheus-stack -n monitoring -f custom-values-ha.yaml
```

### Stap 5: Toegang tot Grafana

Open een web browser en navigeer naar:

```plaintext
http://<node-ip>:31111
```

Vervang `<node-ip>` met het IP-adres van de Kubernetes nodes.

Log in met de standaard credentials (`admin`/`nog in te vullen`).

Verander het wachtwoord wanneer hierom gevraagd wordt.

Voor verdere configuratie van Grafana, zoals het instellen van dashboards en alerting, zie [grafana.md](grafana.md).

### Bijkomende Resources

- [Prometheus Documentation](https://prometheus.io/docs/introduction/overview/)
- [Grafana Documentation](https://grafana.com/docs/grafana/latest/)
- [Kube-Prometheus Stack](https://github.com/prometheus-operator/kube-prometheus)


