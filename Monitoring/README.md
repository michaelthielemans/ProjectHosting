
To document your setup process for Grafana and Prometheus in your GitHub repository using Markdown, you should include detailed steps and configurations. Here's a comprehensive guide you can use as a template:

---

## Monitoring Setup with Prometheus and Grafana

This document outlines the steps to set up monitoring for a Kubernetes cluster using Prometheus and Grafana. 

### Prerequisites

1. Kubernetes cluster with at least one master node and two worker nodes.
2. Helm installed on the master node.
3. Access to the Kubernetes cluster using `kubectl`.

### Step 1: Install Helm Repositories

Add the necessary Helm repositories for Prometheus and Grafana.

```bash
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update
```

### Step 2: Create Namespace for Monitoring

Create a dedicated namespace for monitoring components.

```bash
kubectl create namespace monitoring
```

### Step 3: Install Prometheus Operator

Deploy the Prometheus Operator using Helm.

```bash
helm install prometheus-operator prometheus-community/kube-prometheus-stack --namespace monitoring
```

### Step 4: Expose Grafana Using NodePort

Edit the Grafana service to expose it via NodePort.

1. Open the service definition for editing:

    ```bash
    kubectl edit svc prometheus-operator-grafana -n monitoring
    ```

2. Modify the service type to `NodePort` and specify a NodePort:

    ```yaml
    spec:
      type: NodePort
      clusterIP: 10.97.122.134
      ports:
      - name: http-web
        port: 80
        protocol: TCP
        targetPort: 3000
        nodePort: 31111  # Specify the NodePort
      selector:
        app.kubernetes.io/instance: prometheus-operator
        app.kubernetes.io/name: grafana
    ```

3. Save and exit the editor.

4. Verify the service is updated:

    ```bash
    kubectl get svc prometheus-operator-grafana -n monitoring
    ```

### Step 5: Access Grafana

1. Open a web browser and navigate to:

    ```plaintext
    http://<node-ip>:31111
    ```

   Replace `<node-ip>` with the IP address of any of your Kubernetes nodes.

2. Log in using the default credentials:
   - **Username:** `admin`
   - **Password:** `prom-operator`

3. Change the password when prompted.

### Step 6: Add Prometheus as a Data Source in Grafana

1. In Grafana, navigate to **Configuration** > **Data Sources**.
2. Click **Add data source**.
3. Select **Prometheus**.
4. Enter the Prometheus URL:

    ```plaintext
    http://prometheus-operated:9090
    ```

5. Click **Save & Test** to verify the connection.

### Step 7: Import Grafana Dashboards

1. In Grafana, navigate to **Create** > **Import**.
2. Enter the dashboard ID and click **Load**. Useful dashboards include:
   - **Kubernetes Cluster Monitoring** (ID: 315)
   - **Node Exporter Full** (ID: 1860)
   - **Kubernetes / Compute Resources / Node (Pods)** (ID: 315)
3. Configure the data source for the dashboard (select the Prometheus data source) and click **Import**.

### Step 8: Verify Monitoring Setup

1. Navigate to the imported dashboards in Grafana.
2. Ensure that metrics and visualizations are displayed correctly.

### Troubleshooting

- **Connection Issues:** Ensure firewall rules and security groups allow traffic to the NodePort.
- **Grafana Errors:** Check Grafana logs for detailed error messages and resolve any issues.

### Additional Resources

- [Prometheus Documentation](https://prometheus.io/docs/introduction/overview/)
- [Grafana Documentation](https://grafana.com/docs/grafana/latest/)
- [Kube-Prometheus Stack](https://github.com/prometheus-operator/kube-prometheus)

---
