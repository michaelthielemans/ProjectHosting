# Brute-force conf

#### Wazuh wordt geleverd met een set standaard scripts die worden gebruikt bij actieve respons. Deze scripts bevinden zich in de map `/var/ossec/active-response/bin/` op Linux/Unix endpoints. Het firewall-drop script voor actieve respons werkt met Linux/Unix-besturingssystemen. Het gebruikt iptables om kwaadaardige IP-adressen te blokkeren.

### Open het Wazuh-serverbestand `/var/ossec/etc/ossec.conf` en controleer of er binnen het `<ossec_config>`-blok een `<command>`-blok met de naam firewall-drop en de volgende configuratie aanwezig is:

```xml
<ossec_config>
  ...
  <command>
    <name>firewall-drop</name>
    <executable>firewall-drop</executable>
    <timeout_allowed>yes</timeout_allowed>
  </command>
  ...
</ossec_config>
```
### Het `<command>`-blok bevat informatie over de actie die moet worden uitgevoerd op de Wazuh-agent:

- `<name>`: Stelt een naam in voor het commando. In dit geval, firewall-drop.
- `<executable>`: Geeft het actieve respons-script of uitvoerbare bestand op dat moet worden uitgevoerd bij een trigger. In dit geval is dat de firewall-drop executable.
- `<timeout_allowed>`: Staat een timeout toe na een bepaalde periode. Deze tag is hier ingesteld op yes, wat een stateful actieve respons vertegenwoordigt.

### Voeg het volgende `<active-response>`-blok toe aan het Wazuh-serverbestand `/var/ossec/etc/ossec.conf`:

```xml
<ossec_config>
  ...
  <active-response>
    <command>firewall-drop</command>
    <location>local</location>
    <rules_id>5763</rules_id>
    <timeout>180</timeout>
  </active-response>
  ...
</ossec_config>
```
- `<command>`: Geeft het commando aan dat geconfigureerd moet worden. Dit is de commandonaam firewall-drop die in de vorige stap is gedefinieerd.

- `<location>`: Geeft aan waar het commando wordt uitgevoerd. Het gebruik van de waarde local betekent dat het commando wordt uitgevoerd op het gecontroleerde eindpunt waar het triggergebeurtenis plaatsvindt.

- `<rules_id>`: De actieve responsmodule voert het commando uit als regel-ID 5763 - SSHD brute force trying to get access to the system wordt geactiveerd.

- `<timeout>`: Geeft aan hoelang de actieve responsactie moet duren. In dit geval blokkeert de module gedurende 180 seconden het IP-adres van het eindpunt dat de brute-force-aanval uitvoert.

### Herstart de Wazuh-manager service om de wijzigingen toe te passen:

```sh
sudo systemctl restart wazuh-manager
```

-------------------------------------------------------------------------------------------------

### Test the configuration
#### 1. Hydra te installeren op een Ubuntu-eindpunt
```sh
sudo apt update && sudo apt install -y hydra
```
#### 2. Maak een <PASSWD_LIST.txt> file aan met 10 paswoorden

#### 3. Vervang <RHEL_USERNAME> door de gebruikersnaam van het RHEL-eindpunt, <PASSWD_LIST.txt> door het pad naar het wachtwoordenbestand dat in de vorige stap is gemaakt, en <RHEL_IP> door het IP-adres van het RHEL-eindpunt:

```sh
sudo hydra -t 4 -l <RHEL_USERNAME> -P <PASSWD_LIST.txt> <RHEL_IP> ssh
```

#### Dit zal Hydra gebruiken om SSH-brute-force-aanvallen uit te voeren tegen het RHEL-eindpunt. 

#### Rule ID 5763 fired en IP-blocked voor een aantal minuten.
