## SCA
#### Door regelmatig SCA-scans uit te voeren, kunnen organisaties proactief potentiële beveiligingsrisico's identificeren en aanpakken voordat ze worden misbruikt door kwaadwillende actoren. Dit draagt bij aan het verbeteren van de algehele beveiliging van de systemen en het netwerk. (Restart de wazuh agent voor een nieuwe scan)


#### Voor linux/unix vindt je de policies hier terug: `/var/ossec/ruleset/sca`.


#### 1. Pas de naam van de laatste ubuntu versie file aan naar je huidige ubuntu versie : cis_ubuntu24-04.yml, open deze file en pas hier ook alle versie nummers aan naar 24-04. Verwijder of disable de andere ongebruikte .yml ubuntu files.

### 2. Open de configuration file.`/var/ossec/etc/ossec.conf` Zoek de `<sca>` block in de configuration file.
```xml
  <sca>
    <enabled>yes</enabled>
    <scan_on_start>yes</scan_on_start>
    <interval>12h</interval>
    <skip_nfs>yes</skip_nfs>
    <policies>
      <policy>/var/ossec/ruleset/sca/cis_ubuntu24-04.yml</policy>
    </policies>
  </sca>
```

### 3. Voeg in de agent file '/var/ossec/etc/shared/default/agent.conf'
```xml
  <sca>
    <policies>
      <policy>/var/ossec/ruleset/sca/cis_ubuntu24-04.yml</policy>
    </policies>
  </sca>
```

### 4. Restart de Wazuh agent en manager
```bash
systemctl restart wazuh-agent
systemctl restart wazuh-manager
```
