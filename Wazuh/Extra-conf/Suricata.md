
### 1. Installeer Suricata op het Ubuntu-eindpunt.(agent) 
```bash
sudo add-apt-repository ppa:oisf/suricata-stable
sudo apt-get update
sudo apt-get install suricata -y
```
### 2. Download en pak de Emerging Threats Suricata-regelset uit:
```bash
cd /tmp/ && curl -LO https://rules.emergingthreats.net/open/suricata-6.0.8/emerging.rules.tar.gz
sudo tar -xvzf emerging.rules.tar.gz && sudo mv rules/*.rules /etc/suricata/rules/
sudo chmod 640 /etc/suricata/rules/*.rules
```
### 3. Pas de Suricata-instellingen aan in het bestand /etc/suricata/suricata.yaml en stel de volgende variabelen in (pas overal de juiste interface aan):
```yaml
HOME_NET: "<UBUNTU_IP>"
EXTERNAL_NET: "any"

default-rule-path: /etc/suricata/rules
rule-files:
  - "*.rules"

# Globale statistiekenconfiguratie
stats:
  enabled: no

# Linux high speed capture ondersteuning
af-packet:
  - interface: ens33
```
### 4. Voeg de volgende configuratie toe aan het bestand `/var/ossec/etc/ossec.conf`. Dit stelt de Wazuh-agent in staat om het Suricata-logbestand te lezen:

```xml
<ossec_config>
  <localfile>
    <log_format>json</log_format>
    <location>/var/log/suricata/eve.json</location>
  </localfile>
</ossec_config>
```


---------------------------------------------------------------------------------------------------------------------------------------------------
### 1. controleer of de rule files aanwezig zijn in de /var/lib/suricata/rules/ directory. Als dat niet het geval is, download en plaats ze daar.
```bash
ls /var/lib/suricata/rules/
```
### 2. Download Suricata Rules
Als er geen rule files zijn, kun je de officiële rules downloaden. 
```bash
sudo apt-get install suricata-update
```
### 3. Update de rules:
```bash
sudo suricata-update
```
This command will download the latest rules and place them in the correct directory.

### Stap 4: Zorg ervoor dat Suricata leesrechten heeft voor de regelbestanden en de map.

```bash
sudo chown -R suricata:suricata /var/lib/suricata/rules/
sudo chmod -R 755 /var/lib/suricata/rules/
```

### Stap 5: restart suricata
```bash
sudo systemctl restart suricata
```
