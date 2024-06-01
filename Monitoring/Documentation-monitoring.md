## Waarom Prometheus en Grafana?

### Redenen voor het Gebruik van Prometheus en Grafana

#### Prometheus
Prometheus is een krachtige en flexibele open-source monitoring- en waarschuwingsoplossing die speciaal is ontworpen voor moderne cloud-native omgevingen zoals Kubernetes. Enkele belangrijke redenen om Prometheus te gebruiken zijn:

1. **Efficiëntie**: Prometheus is zeer efficiënt in het verzamelen en opslaan van grote hoeveelheden tijdreeksdata.
2. **Kubernetes Integratie**: Prometheus integreert naadloos met Kubernetes en kan eenvoudig worden ingesteld om automatisch metrieken van alle pods en services in een cluster te verzamelen.
3. **Alerting**: Prometheus biedt uitgebreide mogelijkheden voor het instellen van alerts, zodat je proactief kunt reageren op problemen in je omgeving.

#### Grafana
Grafana is een open-source platform voor monitoring en observability dat krachtige visualisaties biedt voor de gegevens die door Prometheus worden verzameld. Enkele belangrijke redenen om Grafana te gebruiken zijn:

1. **Gebruiksvriendelijke Interface**: Grafana heeft een intuïtieve interface waarmee je eenvoudig dashboards kunt maken en beheren.
2. **Flexibele Visualisaties**: Grafana ondersteunt verschillende soorten visualisaties die helpen bij het interpreteren van de gegevens.
3. **Alerting Integratie**: Grafana integreert goed met Prometheus voor het configureren en beheren van alerts.

### Waarom Geen Andere Monitoring Setup?

Hoewel er andere monitoring tools beschikbaar zijn, zoals Zabbix, Nagios, en New Relic, zijn Prometheus en Grafana specifiek ontworpen voor de dynamische en schaalbare aard van Kubernetes-omgevingen. Andere tools kunnen complexer zijn om te configureren of bieden mogelijk niet dezelfde mate van integratie met Kubernetes als Prometheus en Grafana.

### Waarom Prometheus-Operator?

De Prometheus-Operator vereenvoudigt en automatiseert de implementatie en het beheer van Prometheus-monitoringstacks in Kubernetes-clusters. Hier zijn enkele redenen waarom we de Prometheus-Operator gebruiken:

1. **Automatisering**: De Prometheus-Operator automatiseert veel van de taken die anders handmatig zouden moeten worden uitgevoerd, zoals het instellen van Prometheus-servers, het beheren van configuraties en het beheren van regels voor waarschuwingen.
2. **Configuratiebeheer**: Het gebruik van Kubernetes Custom Resource Definitions (CRD's) maakt het eenvoudig om Prometheus en zijn componenten te configureren en te beheren met behulp van Kubernetes-resources.
3. **Schaalbaarheid**: De Prometheus-Operator ondersteunt horizontale schaalbaarheid, waardoor meerdere replica's van Prometheus-instanties kunnen worden uitgevoerd voor hoge beschikbaarheid.
4. **Eenvoudige Integratie**: De Operator integreert goed met andere Kubernetes-componenten, zoals Alertmanager en Grafana, en zorgt voor een coherente monitoringstack.
5. **Best Practices**: Door de Prometheus-Operator te gebruiken, kunnen we profiteren van best practices en gemeenschapsgebaseerde configuraties die zijn ingebakken in de Operator.

### Doel van de Prometheus-Operator

Het doel van de Prometheus-Operator is om het eenvoudig te maken om een volledig functionele en geconfigureerde Prometheus-instantie te draaien in een Kubernetes-cluster. Dit omvat:

- **Implementatie**: Het snel en betrouwbaar implementeren van Prometheus en zijn componenten.
- **Beheer**: Het vereenvoudigen van het beheer van Prometheus-configuraties, inclusief scrape-configuraties en alerting-regels.
- **Schaalbaarheid en Betrouwbaarheid**: Het ondersteunen van hoge beschikbaarheid door middel van replicatie en het beheren van meerdere Prometheus-instanties.

## Doorlopen Stappen voor de Installatie en Configuratie

Hieronder worden de stappen beschreven die ik heb doorlopen om Prometheus en Grafana te installeren en te configureren. Er is ruimte gelaten voor het toevoegen van screenshots om de stappen visueel te ondersteunen.

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

Vervang `<node-ip>` met het IP-adres van de Kubernetes nodes. Log in met de standaard credentials (`admin`/`prom-operator`). Verander het wachtwoord wanneer hierom gevraagd wordt.

### Stap 6: Voeg Prometheus toe als Data Source in Grafana

1. In Grafana, navigeer naar **Configuration** > **Data Sources**.
2. Klik op **Add data source**.
3. Selecteer **Prometheus**.
4. Vul de Prometheus URL in:

    ```plaintext
    http://prometheus-operated:9090
    ```

5. Klik op **Save & Test** om de connectie te verifiëren.

### Stap 7: Import Grafana Dashboards

1. In Grafana, navigeer naar **Create** > **Import**.
2. Voeg een dashboard ID toe en klik op **Load**.
3. Configureer de gegevensbron indien nodig en sla op.

### Problemen en Oplossingen

Onderstaande problemen en oplossingen zijn enkele van de meest impactvolle die wij in het installatie en proces ondervonden.

#### SMTP Connectie Problemen

**Probleem**: De Grafana pod kon geen verbinding maken met de SMTP-server, waardoor e-mailnotificaties niet werkten.

**Oplossing**:
1. Controleer de SMTP instellingen in de `custom-values-ha.yaml`.
2. Verifieer netwerkconnectiviteit vanuit de Grafana pod naar de SMTP-server met `telnet` of `curl`.

```sh
kubectl exec -it <grafana-pod-name> -n monitoring -- curl -4 -v telnet://smtp.gmail.com:587
```

#### Sessiebeheer Probleem bij Meerdere Replicas

**Probleem**: Wanneer het aantal replicas voor Grafana werd verhoogd naar 2, traden er sessiebeheerproblemen op.

**Oorzaak**: Dit probleem kan te wijten zijn aan het gebruik van NodePort, waardoor sessies niet correct worden gedeeld tussen de pods.

**Oplossing**:
1. Gebruik een LoadBalancer of Ingress Controller om sessiebeheer beter te ondersteunen.
2. Configureer sessionAffinity in de service definitie om sessies naar dezelfde pod te leiden.
3. Laat het aantal replicas op 1

```yaml
service:
  type: NodePort
  port: 80
  targetPort: 3000
  nodePort: 30000-32767
  sessionAffinity: ClientIP
```

#### Persistentie Probleem met Replicas

**Probleem**: Door het toevoegen van `persistence: true` in de custom values file kwamen er extra pods in de status `Pending`.

**Oplossing**:
1. Verwijder de `persistence: true` regel uit de `custom-values-ha.yaml`.
2. Schaal het aantal replicas tijdelijk naar 0 en dan terug naar 1, en verwijder handmatig de `Pending` pod.

```bash
kubectl scale deployment prometheus-operator-grafana --replicas=0 -n monitoring
kubectl scale deployment prometheus-operator-grafana --replicas=1 -n monitoring
kubectl delete pod <pending-pod-name> -n monitoring
```

### Conclusie

Door het gebruik van Prometheus en Grafana voor het monitoren van een Kubernetes-cluster kan een krachtige en flexibele monitoringoplossing worden gerealiseerd. Deze tools bieden uitgebreide mogelijkheden voor het verzamelen van metrieken, het instellen van alerts en het visualiseren van data. De beschreven stappen en oplossingen helpen bij het effectief opzetten en onderhouden van deze tools in een productieomgeving.


