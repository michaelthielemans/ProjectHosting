# Grafana Configuratie

Dit document beschrijft de stappen om Grafana te configureren na de initiële installatie, inclusief het instellen van SMTP, dashboards en alerting.

## SMTP Configuratie voor E-mail Notificaties

### SMTP Instellingen in custom-values-ha.yaml

Voeg de SMTP instellingen toe aan je `custom-values-ha.yaml` bestand:

```yaml
prometheus:
  prometheusSpec:
    replicas: 1
    retention: 10d

grafana:
  replicas: 1
  smtp:
    enabled: true
    host: smtp.gmail.com:587   # Replace with your SMTP server
    user: linuxprojecthosting@gmail.com  # Replace with your email address
    password: invullen # Replace with your email password
    from_address: linuxprojecthosting@gmail.com  # Replace with the sender email address
    from_name: Grafana
  env:
    GF_SMTP_ENABLED: "true"
    GF_SMTP_HOST: "smtp.gmail.com:587"
    GF_SMTP_USER: "linuxprojecthosting@gmail.com"
    GF_SMTP_PASSWORD: "invullen"
    GF_SMTP_FROM_ADDRESS: "linuxprojecthosting@gmail.com"
    GF_SMTP_FROM_NAME: "Grafana"
  service:
    type: NodePort
    port: 80
    targetPort: 3000
    nodePort: 31111
```
### Nakijken SMTP settings in de pod

Controleer de grafana pod naam en maak verbinding met de pod. Eenmaal op de pod toon de SMTP variabelen.

![image](https://github.com/michaelthielemans/ProjectHosting/assets/119010746/ea819650-5b9d-4814-8802-043cdd3e1fd4)




### Waarom we de NodePort aanpassen in de custom values

Door de NodePort in de `custom-values-ha.yaml` te definiëren, zorg je ervoor dat de Grafana-service altijd via dezelfde poort toegankelijk is, ongeacht herinstallaties of updates. Dit voorkomt de noodzaak om handmatige aanpassingen aan de service te doen na elke herinstallatie of upgrade en zorgt voor consistentie in de toegang tot de Grafana-interface. 

Het gebruik van een NodePort maakt het ook mogelijk om Grafana extern toegankelijk te maken via een specifieke poort op de nodes in het Kubernetes-cluster.

### Apply the Configuration

Pas de configuratie toe met Helm:

```bash
helm upgrade --install prometheus-operator prometheus-community/kube-prometheus-stack -n monitoring -f custom-values-ha.yaml
```

![image](https://github.com/michaelthielemans/ProjectHosting/assets/119010746/e4930f32-431f-4373-b13e-59184351a428)
![image](https://github.com/michaelthielemans/ProjectHosting/assets/119010746/7a358861-0e5b-4195-ac86-d4a2a9b27ca7)



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

