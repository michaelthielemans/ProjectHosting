
---

## Monitoring Installatie met Prometheus en Grafana

Dit document omvat de verschillende stappen voor de installatie en configuratie van monitoring van een Kubernetes cluster gebruik makend van Prometheus en Grafana.

### Prerequisites

1. Kubernetes cluster met minstens 1 master node en 2 worker nodes.
2. Helm geinstalleerd.
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

### Stap 4: Expose Grafana met NodePort

Edit de Grafana service.

1. Open de service definition voor editing:

    ```bash
    kubectl edit svc prometheus-operator-grafana -n monitoring
    ```

2. Pas de service type aan naar `NodePort` and specifieer de NodePort:

    ```yaml
    spec:
      type: NodePort
      clusterIP: 10.97.122.134
      ports:
      - name: http-web
        port: 80
        protocol: TCP
        targetPort: 3000
        nodePort: 31111  # Specifier de NodePort
      selector:
        app.kubernetes.io/instance: prometheus-operator
        app.kubernetes.io/name: grafana
    ```

3. Save en exit de editor.

4. Verifieer of de service geupdate is:

    ```bash
    kubectl get svc prometheus-operator-grafana -n monitoring
    ```

### St5p 5: Toegang tot Grafana

1. Open een web browser en navigeer naar:

    ```plaintext
    http://<node-ip>:31111
    ```

   Vervang `<node-ip>` met het IP address van de Kubernetes nodes.

2. Log in met de credentials.

3. Verander het password wanneer erom gevraagd wordt.

### Stap 6: Voeg Prometheus toe als Data Source in Grafana

1. In Grafana, navigeer naar **Configuration** > **Data Sources**.
2. Click **Add data source**.
3. Select **Prometheus**.
4. Enter de Prometheus URL:

    ```plaintext
    http://prometheus-operated:9090
    ```

5. Click **Save & Test** om de connectie te verifieren.

### Stap 7: Import Grafana Dashboards

1. In Grafana, navigeer naar **Create** > **Import**.
2. Voeg een dashboard ID toe and click **Load**.

### Stap 8: Verify Monitoring Setup

1. Navigeer naar de geimporteerde dashboards in Grafana.
2. Controleer of de metrics and visualizations correct getoond worden.

### Troubleshooting

- **Connection Issues:** Controleer of de firewall regels en veiligheids groepen verkeer toestaan naar de NodePort.
- **Grafana Errors:** Check Grafana logs voor gedetaileerde error messages en los eventuele problemenop.

### Bijkomende Resources

- [Prometheus Documentation](https://prometheus.io/docs/introduction/overview/)
- [Grafana Documentation](https://grafana.com/docs/grafana/latest/)
- [Kube-Prometheus Stack](https://github.com/prometheus-operator/kube-prometheus)

---
