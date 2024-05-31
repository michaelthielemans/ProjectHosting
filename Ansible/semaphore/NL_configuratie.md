# Configureren van Semaphore

Nadat Semaphore is geïnstalleerd, kun je de configuratie starten in de volgende volgorde:

1. De interface zal je vragen om een nieuw project aan te maken.
2. Maak sleutels aan.
3. Maak een inventaris aan.
4. Verbind een repository.
5. Maak een taaksjabloon aan.

## 1. Een nieuw project
Gebruik hiervoor een unieke naam.

## 2. Sleutels en logins aanmaken
Voordat je kunt verbinden met de externe doelen, moet je nieuwe SSH-sleutels aanmaken. De server heeft een privésleutel nodig en het externe doel moet het openbare sleuteldeel van het sleutelpaar hebben. Het sleutelpaar zal verificatie en encryptie bieden.

### 2.1 SSH-sleutel aanmaken
#### 2.1.A Genereren van een SSH-privé/publiek sleutelpaar
Dit kan worden gedaan op je lokale machine of op de Semaphore-server zelf, het maakt niet uit waar je het sleutelpaar maakt.
- `ssh-keygen`
  > Dit is het gereedschap om sleutelparen te genereren, extra parameters kunnen worden ingesteld indien nodig. Als je het sleuteltype wilt wijzigen, gebruik dan `-t <sleuteltype>`, bijvoorbeeld `ssh-keygen -t rsa`.
- Voer bestandsnaam/locatie in
  > Dit is de locatie waar de sleutel zal worden opgeslagen, je kunt deze standaard laten, ook de locatie is niet van groot belang omdat de privésleutel uiteindelijk zal worden ingevoerd in de Semaphore-webinterface en het openbare deel zal worden gekopieerd naar de externe doelen.
- `voer wachtwoord in`
  > Dit is optioneel. Als je een wachtwoord gebruikt, moet je dit wachtwoord toevoegen aan de Semaphore-UI bij het invoeren van een nieuwe SSH-sleutel.

#### 2.1.B. Kopieer het openbare deel van het sleutelpaar naar de externe doelen

`ssh-copy-id -i ~/.ssh/id_rsa.pub master@172.24.1.105`

> Kopieer de publieke sleutel naar de authorizers van de master.
> Na het voltooien van dit commando wordt de publieke sleutel toegevoegd aan het bestand `/home/master/.ssh/authorized_keys`. Het zal de sleutel kopiëren naar de home-dir-locatie van de gebruikers van waaruit je de ssh-sessie bent gestart.
> -> Als een machine verbinding maakt met de externe met een SSH-sleutel, zal de externe controleren of hij een overeenkomstige publieke sleutel beschikbaar heeft in een van zijn `authorized_keys`-bestanden. Afhankelijk van de locatie van deze publieke sleutel wordt de sessie gebonden aan die gebruiker.

#### 2.1.C. Voeg de privésleutel toe aan de sleutelopslag in Semaphore
1. Open sleutelopslag.
2. Nieuwe sleutel:
   > Type = SSH-sleutel
   > Gebruikersnaam = laat leeg
   > Wachtwoord = als je er tijdens de aanmaak van het sleutelpaar een hebt toegevoegd
   > Plak de privésleutel in het veld.

### 2.2 Logins aanmaken
Als je sudo-rechten nodig hebt.

#### 2.2.A. Voeg een nieuwe sleutel toe
> Selecteer inloggen met wachtwoord.
> ⁉️Laat het wachtwoord leeg -> dit is een bekende bug, omdat je al verbinding maakt via een SSH-sleutel die is gekoppeld aan een gebruiker, hoef je deze niet opnieuw toe te voegen hier.
> Voer het wachtwoord in van het account dat je wilt gebruiken op de externe doelen.

#### 2.2.B. Voeg het gebruikte account op de externe doelen toe aan het sudoers-bestand.
`sudo vim /etc/sudoers.d/<gebruikersnaam>`

Voeg de volgende regel toe aan het bestand.
`<gebruikersnaam> ALL=(ALL) NOPASSWD: ALL`

### 3. Een inventaris aanmaken
1. Inventaris toevoegen.
2. Gebruikersreferenties -> selecteer de SSH-sleutel die je eerder hebt toegevoegd.
3. Sudo-referenties -> selecteer de inloggegevens met wachtwoord die je eerder hebt toegevoegd.
4. Voeg een lijst met IP's toe.

### 4. Verbind een repository
1. Maak een nieuwe GitHub-repository aan en kopieer de https://-link [https://github.com/michaelthielemans/ansible/tree/main/playbooks](https://github.com/michaelthielemans/ansible/tree/main/playbooks)
2. Plak de link.
3. Branch -> main.
4. Toegangssleutel => geen als de repository openbaar is.

### 5. Een taaksjabloon aanmaken
- Playbook-bestandsnaam = de naam van het bestand dat je aan de GitHub-repository hebt toegevoegd.
- Omgeving = leeg.
- Vault = laat leeg.
