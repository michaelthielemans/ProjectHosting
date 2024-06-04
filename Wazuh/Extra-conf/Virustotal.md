# Virus-Total

#### Maak eerst een API code op de website van virus-total met een account.

## Ubuntu endpoint.


### 1. Deze code zet je in de "/var/ossec/etc/ossec.conf" in de <syscheck> block.

```xml
<ossec_config>
  ...
   <directories realtime="yes">/root</directories>
  ...
</ossec_config>
```

### 2. Zet 'disabled' naar 'no'.


### 3. Install jq, voor JSON input from the active response script.

```bash
sudo apt update
sudo apt -y install jq
```

### 4. Maak een script om malicious files te verwijderen "/var/ossec/active-response/bin/remove-threat.sh"

```xml
#!/bin/bash

LOCAL=`dirname $0`;
cd $LOCAL
cd ../

PWD=`pwd`

read INPUT_JSON
FILENAME=$(echo $INPUT_JSON | jq -r .parameters.alert.data.virustotal.source.file)
COMMAND=$(echo $INPUT_JSON | jq -r .command)
LOG_FILE="${PWD}/../logs/active-responses.log"

#------------------------ Analyze command -------------------------#
if [ ${COMMAND} = "add" ]
then
 # Send control message to execd
 printf '{"version":1,"origin":{"name":"remove-threat","module":"active-response"},"command":"check_keys", "parameters":{"keys":[]}}\n'

 read RESPONSE
 COMMAND2=$(echo $RESPONSE | jq -r .command)
 if [ ${COMMAND2} != "continue" ]
 then
  echo "`date '+%Y/%m/%d %H:%M:%S'` $0: $INPUT_JSON Remove threat active response aborted" >> ${LOG_FILE}
  exit 0;
 fi
fi

# Removing file
rm -f $FILENAME
if [ $? -eq 0 ]; then
 echo "`date '+%Y/%m/%d %H:%M:%S'` $0: $INPUT_JSON Successfully removed threat" >> ${LOG_FILE}
else
 echo "`date '+%Y/%m/%d %H:%M:%S'` $0: $INPUT_JSON Error removing threat" >> ${LOG_FILE}
fi

exit 0;
```
### 5. Verander van /var/ossec/active-response/bin/remove-threat.sh het file ownership, and permissions:
```bash
sudo chmod 750 /var/ossec/active-response/bin/remove-threat.sh
sudo chown root:wazuh /var/ossec/active-response/bin/remove-threat.sh
```

### 6. Herstart de Wazuh-agent service om de wijzigingen toe te passen:

```sh
sudo systemctl restart wazuh-agent
```

## Wazuh server.

### 1. Voeg deze rules in "/var/ossec/etc/rules/local_rules.xml"
```xml
<group name="syscheck,pci_dss_11.5,nist_800_53_SI.7,">
    <!-- Rules for Linux systems -->
    <rule id="100200" level="7">
        <if_sid>550</if_sid>
        <field name="file">/root</field>
        <description>File modified in /root directory.</description>
    </rule>
    <rule id="100201" level="7">
        <if_sid>554</if_sid>
        <field name="file">/root</field>
        <description>File added to /root directory.</description>
    </rule>
</group>
```

### 2. Voeg deze block toe aan de server conf file "/var/ossec/etc/ossec.conf", zet op de api-code je eigen code van virustotal
```xml
<ossec_config>
  <integration>
    <name>virustotal</name>
    <api_key><YOUR_VIRUS_TOTAL_API_KEY></api_key> <!-- Replace with your VirusTotal API key -->
    <rule_id>100200,100201</rule_id>
    <alert_format>json</alert_format>
  </integration>
</ossec_config>

```

### 3. Zet de volgende blocks ook in de  "/var/ossec/etc/ossec.conf" file van de wazuh server. This enables active response and triggers the remove-threat.sh script when VirusTotal flags a file as malicious:

```xml
<ossec_config>
  <command>
    <name>remove-threat</name>
    <executable>remove-threat.sh</executable>
    <timeout_allowed>no</timeout_allowed>
  </command>

  <active-response>
    <disabled>no</disabled>
    <command>remove-threat</command>
    <location>local</location>
    <rules_id>87105</rules_id>
  </active-response>
</ossec_config>
```

### 4. Zet de volgende rules ook in "/var/ossec/etc/rules/local_rules.xml" om: to alert about the active response results:

```xml
<group name="virustotal,">
  <rule id="100092" level="12">
    <if_sid>657</if_sid>
    <match>Successfully removed threat</match>
    <description>$(parameters.program) removed threat located at $(parameters.alert.data.virustotal.source.file)</description>
  </rule>

  <rule id="100093" level="12">
    <if_sid>657</if_sid>
    <match>Error removing threat</match>
    <description>Error removing threat located at $(parameters.alert.data.virustotal.source.file)</description>
  </rule>
</group>

```
### 5. Restart de wazuh manager server
```bash
sudo systemctl restart wazuh-manager
```
