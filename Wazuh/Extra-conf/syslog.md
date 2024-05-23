# Syslogs ontvangen op de Wazuh Server

De Wazuh server kan logs verzamelen via syslog van eindpunten zoals firewalls, switches, routers en andere apparaten die geen ondersteuning bieden voor de installatie van Wazuh agents. 

## Via terminal
### 1. Bewerk het Wazuh Configuratiebestand
Open het Wazuh configuratiebestand

```bash
sudo nano /var/ossec/etc/ossec.conf
```

### 2. Voeg de Syslog Configuratie Toe
Voeg het volgende configuratieblok toe tussen de `<ossec_config>` tags in het `ossec.conf` bestand. Dit blok configureert de Wazuh server om te luisteren naar syslog-berichten op TCP poort 514.

- **"allowed-ips"** is het IP-adres of netwerkbereik van de endpoints die gebeurtenissen doorsturen naar de Wazuh-server. In dit voorbeeld gebruiken we `192.168.2.15/24`.
- **"local_ip"** is het IP-adres van de Wazuh-server die luistert naar inkomende logberichten. In het bovenstaande voorbeeld gebruiken we `192.168.2.10`.


```xml
<remote>
  <connection>syslog</connection>
  <port>514</port>
  <protocol>tcp</protocol>
  <allowed-ips>192.168.2.15/24</allowed-ips>
  <local_ip>192.168.2.10</local_ip>
</remote>
```

### 3. Herstart de Wazuh Manager

Om de wijzigingen toe te passen, herstart de Wazuh manager met het volgende commando:

```bash
sudo systemctl restart wazuh-manager
```

## Via dashboard

### 1. Navigeer naar de Ossec file in manager
![syslog1](https://github.com/michaelthielemans/ProjectHosting/assets/118989454/9aa80e81-e7d7-4087-b448-52aae7e6f6f5)
### 2. Voeg het volgende configuratieblok toe.
![syslog2](https://github.com/michaelthielemans/ProjectHosting/assets/118989454/5b4b4042-4496-4ef9-b462-e56f98875992)
### 3. Save
![syslog3](https://github.com/michaelthielemans/ProjectHosting/assets/118989454/e5ab118f-7347-4e6a-a973-434a4a0df4f2)
### 4. Restart manager
![syslog4](https://github.com/michaelthielemans/ProjectHosting/assets/118989454/ac0e4407-b599-47db-ba9a-9bec5060fb83)

