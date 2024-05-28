### High Availability Setup voor Prometheus en Grafana

#### Prerequisites

- Een actieve Kubernetes cluster.
- Helm installed en geconfigureerd.
- Prometheus Operator Helm chart repository toegevoegd.

#### Toevoegen Prometheus Operator Helm Repository

```sh
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
```

#### Custom Values File

Maak een file genaamd `custom-values-ha.yaml` met de volgende content om Prometheus en Grafana te configureren voor  high availability:

```yaml
prometheus:
  prometheusSpec:
    replicas: 2
    retention: 10d

grafana:
  replicas: 2
```

#### Deploying Prometheus and Grafana met Helm

Apply de custom waardes file door volgende Helm upgrade command:

```sh
helm upgrade --install prometheus-operator prometheus-community/kube-prometheus-stack -n monitoring -f custom-values-ha.yaml
```

#### Controle van de Deployment

Check the status of the pods to ensure that the replicas have been updated:

```sh
kubectl get pods -n monitoring
```

### Troubleshooting en Manuele Fixes

Als het aantal Promehteus replicas niet up to date is, volg onderstaande stappen:

1. **Controle Helm Values in de Release**

   ```sh
   helm get values prometheus-operator -n monitoring
   ```
   De output dient volgende te bevatten:

   ```yaml
   prometheus:
     prometheusSpec:
       replicas: 2
       retention: 10d
   grafana:
     replicas: 2
   ```

2. **Check StatefulSet Configuratie**

   ```sh
   kubectl get statefulset prometheus-prometheus-operator-kube-p-prometheus -n monitoring -o yaml | grep replicas
   ```

   Als de replicas waarde nog altijd `1` is, voeg manueel volgende edit toe aan de StatefulSet.

3. **Manuele Edit StatefulSet**

   ```sh
   kubectl edit statefulset prometheus-prometheus-operator-kube-p-prometheus -n monitoring
   ```

   In de editor, verander het `replicas` veld naar `2`:

   ```yaml
   spec:
     replicas: 2
   ```

   Save en exit de editor.

4. **Check Events en Logs**

   Als er problemen zijn met scheduling of resource allocation, de events en logs zullen nuttige informatie verstrekken:

   ```sh
   kubectl describe statefulset prometheus-prometheus-operator-kube-p-prometheus -n monitoring
   kubectl get events -n monitoring
   ```

### voorbeeld controle

Na uitvoeren van de updates, controleer het aantal prometheus en grafana pods:

```sh
kubectl get pods -n monitoring
```

Verwachte output:

```sh
NAME                                                      READY   STATUS    RESTARTS   AGE
alertmanager-prometheus-operator-kube-p-alertmanager-0    2/2     Running   0          24h
prometheus-operator-grafana-67d8b67448-bgh6n              3/3     Running   0          48s
prometheus-operator-grafana-67d8b67448-tss88              3/3     Running   0          24h
prometheus-operator-kube-p-operator-57b968ff84-92ffx      1/1     Running   0          24h
prometheus-operator-kube-state-metrics-54fc68f7bd-cv4gg   1/1     Running   0          24h
prometheus-operator-prometheus-node-exporter-848pb        1/1     Running   0          24h
prometheus-operator-prometheus-node-exporter-dqfmh        1/1     Running   0          24h
prometheus-operator-prometheus-node-exporter-kfzgp        1/1     Running   0          24h
prometheus-operator-prometheus-node-exporter-t2sjv        1/1     Running   0          24h
prometheus-operator-prometheus-node-exporter-v5d9w        1/1     Running   0          24h
prometheus-operator-prometheus-node-exporter-wrg4f        1/1     Running   0          24h
prometheus-prometheus-operator-kube-p-prometheus-0        2/2     Running   0          24h
prometheus-prometheus-operator-kube-p-prometheus-1        2/2     Running   0          10m
```

### Einde

