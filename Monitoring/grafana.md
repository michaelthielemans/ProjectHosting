# Grafana Configuratie

Dit document beschrijft de stappen om Grafana te configureren na de initiële installatie, inclusief het instellen van SMTP, dashboards en alerting.

## SMTP Configuratie voor E-mail Notificaties

### SMTP Instellingen in custom-values-ha.yaml

Voeg de SMTP instellingen toe aan je `custom-values-ha.yaml` bestand:

```yaml
grafana:
  replicas: 2
  smtp:
    enabled: true
    host: smtp.gmail.com:587
    user: linuxprojecthosting@gmail.com
    password: fjfr berk azzn kaoh
    from_address: linuxprojecthosting@gmail.com
    from_name: Grafana
  env:
    - name: GF_SMTP_ENABLED
      value: "true"
    - name: GF_SMTP_HOST
      value: "smtp.gmail.com:587"
    - name: GF_SMTP_USER
      value: "linuxprojecthosting@gmail.com"
    - name: GF_SMTP_PASSWORD
      value: "fjfr berk azzn kaoh"
    - name: GF_SMTP_FROM_ADDRESS
      value: "linuxprojecthosting@gmail.com"
    - name: GF_SMTP_FROM_NAME
      value: "Grafana"
  service:
    type: NodePort
    port: 80
    targetPort: 3000
    nodePort: 31111
```

### Waarom we de NodePort aanpassen in de custom values

Door de NodePort in de `custom-values-ha.yaml` te definiëren, zorg je ervoor dat de Grafana-service altijd via dezelfde poort toegankelijk is, ongeacht herinstallaties of updates. Dit voorkomt de noodzaak om handmatige aanpassingen aan de service te doen na elke herinstallatie of upgrade en zorgt voor consistentie in de toegang tot de Grafana-interface. 

Het gebruik van een NodePort maakt het ook mogelijk om Grafana extern toegankelijk te maken via een specifieke poort op de nodes in het Kubernetes-cluster.

### Apply the Configuration

Pas de configuratie toe met Helm:

```bash
helm upgrade --install prometheus-operator prometheus-community/kube-prometheus-stack -n monitoring -f custom-values-ha.yaml
```

## Dashboards Toevoegen

### Voeg Prometheus toe als Data Source in Grafana

1. In Grafana, navigeer naar **Configuration** > **Data Sources**.
2. Klik op **Add data source**.
3. Selecteer **Prometheus**.
4. Vul de Prometheus URL in:

    ```plaintext
    http://prometheus-operated:9090
    ```

5. Klik op **Save & Test** om de connectie te verifiëren.

### Import Grafana Dashboards

1. In Grafana, navigeer naar **Create** > **Import**.
2. Voeg een dashboard ID toe en klik op **Load**.
3. Configureer de gegevensbron indien nodig en sla op.

## Alerting Instellen

### Configureer E-mail Notificaties

1. In Grafana, ga naar **Alerting** > **Contact points**.
2. Klik op **New contact point**.
3. Configureer de e-mail instellingen.
4. Klik op **Test** om een test e-mail te versturen en de configuratie te verifiëren.

### Maak een Alert

1. Ga naar een dashboard en klik op een grafiek.
2. Klik op **Edit** en ga naar het **Alert** tabblad.
3. Configureer de alert voorwaarden en acties.
4. Sla de alert op.

## Extra Hulpbronnen

- [Prometheus Documentation](https://prometheus.io/docs/introduction/overview/)
- [Grafana Documentation](https://grafana.com/docs/grafana/latest/)
- [Kube-Prometheus Stack](https://github.com/prometheus-operator/kube-prometheus)

