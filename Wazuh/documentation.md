![wazuh-logo-main-02](https://github.com/michaelthielemans/ProjectHosting/assets/118989454/9c31ee45-3d8f-4458-a839-1d492b5a60ce)

1. [Hardware recommendations](#hardware-recommendations)
2. [Taakverdeling](#taakverdeling)
3. [Samenwerkingsoverzicht](#samenwerkingsoverzicht)
4. [Uitgebreide Samenvatting van de Functies/Mogelijkheden](#uitgebreide-samenvatting-van-de-functiesmogelijkheden)
5. [Bronnen](#bronnen)



# <br/>Hardware recommendations:
![dash](https://github.com/michaelthielemans/ProjectHosting/assets/118989454/440739fc-64f6-4339-9e9a-fe8ac0ab35a9)<br/><br/>
![server](https://github.com/michaelthielemans/ProjectHosting/assets/118989454/d9a07ac3-50cf-4497-9469-baee58444962)<br/><br/>
![index](https://github.com/michaelthielemans/ProjectHosting/assets/118989454/b37d1df5-4c33-49a0-83d9-99835563c4d2)<br/><br/>
![agents](https://github.com/michaelthielemans/ProjectHosting/assets/118989454/8732dc8a-eec2-4d47-afc9-5be3b1d9aaa7)




# <br/>Taakverdeling:

### <u>Wazuh Manager:</u>

- Centrale hub voor beveiligingsbewaking.
- Verzamelt, analyseert en interpreteert loggegevens van Wazuh Agents/Indexer op bewaakte machines.
- Detecteert bedreigingen en genereert waarschuwingen.


### Wazuh Agent:

- Geïnstalleerd op te bewaken machines.
- Verzamelt lokale loggegevens, systeemactiviteiten, en controleert bestandsintegriteit.
- Detecteert rootkits en stuurt gegevens door naar de Wazuh Indexer.

### Wazuh Indexer:

- Opslaan en indexeren van loggegevens verzameld door Wazuh Agents.
- Indexeert en slaat loggegevens op in Elasticsearch.
- Biedt zoekfunctionaliteit en real-time analyse.
- Ondersteunt opslag en retentie van loggegevens.


### Dashboard:

- Geeft een overzicht van de beveiligingsstatus.
- Toont geaggregeerde informatie over bedreigingen en waarschuwingen.
- Biedt visualisaties van loggegevens en trends.
- Stelt beheerders in staat om snel te reageren op beveiligingsincidenten.

### Wazuh Ruleset:

- Set van detectieregels voor identificatie van verdachte activiteiten en bedreigingen.
- Toegepast op loggegevens verzameld door Wazuh Agents en geanalyseerd door de Wazuh Manager.
- Aanpasbaar aan specifieke beveiligingsbehoeften van een organisatie.
- Draagt bij aan de detectie van beveiligingsincidenten.


# <br/>Samenwerkingsoverzicht:
- **Wazuh Agents:** Verzamelen loggegevens en sturen deze naar de Wazuh Indexer.
- **Wazuh Indexer:** Slaat loggegevens op, indexeert ze, en biedt zoekfunctionaliteit.
- **Wazuh Manager:** Analyseert gegevens van de Wazuh Indexer met behulp van de Wazuh Ruleset.
- **Waarschuwingen:** Bij detectie van bedreigingen worden waarschuwingen naar de Wazuh Indexer gestuurd.
- **Beheerders:** Gebruiken de Wazuh App voor Kibana om gegevens te visualiseren en te reageren op bedreigingen.<br/><br/>

![poc-lab-env-arch1](https://github.com/michaelthielemans/ProjectHosting/assets/118989454/31e63333-0cfb-418e-94f8-df600de45a74)






# <br/>Uitgebreide Samenvatting van de Functies/Mogelijkheden

#### Beveiligingsbewaking:
- **Loggegevensverzameling:**
  - Verzamelt loggegevens van verschillende bronnen, analyseert en interpreteert deze in real-time.
- **Detectie van bedreigingen:**
  - Identificeert verdachte activiteiten, malware-infecties en inbraakpogingen.
- **Intelligentie en correlatie:**
  - Minimaliseert valse positieven door geavanceerde algoritmen en correlatie-technieken.

#### Intrusiedetectie en preventie:
- **Detectie van aanvallen:**
  - Herkent exploits, brute-force-aanvallen, malware en misbruik van kwetsbaarheden.
- **Zero-day-aanvallen:**
  - Detecteert afwijkend gedrag
- **Preventie en respons:**
  - Neemt actief tegenmaatregelen, zoals het blokkeren van IP-adressen.

#### Bestandsintegriteitscontrole:
- **Integriteitsbewaking**
- **Detectie van wijzigingen**
- **Waarschuwingen en rapportage**

#### Vulnerability Management:
- **Kwetsbaarheidsscanning:**
  - Identificeert zwakke plekken en kwetsbaarheden in systemen en applicaties.
- **Prioritering van kwetsbaarheden**
- **Integratie met CVE-databases:**
  - Geeft up-to-date informatie over bekende kwetsbaarheden en patches.

#### Compliance Auditing:
- **Auditing en rapportage**
- **Automatische controles**
- **Rapportage en dashboards**

#### Schaalbaarheid en Integratie:
- **Schaalbaarheid**
- **Integratie met andere tools**
- **API's en extensies**
    
![Wazuh-dash](https://github.com/michaelthielemans/ProjectHosting/assets/118989454/1dbaa2e2-c1ba-4d77-ab72-35edaf710d01)

# <br/>Bronnen
- **https://documentation.wazuh.com/**
- **https://cybrhat.nl/cybersecurity/blog/cybersecurity**
