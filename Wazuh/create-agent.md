# Wazuh Agent Toevoegen via het Dashboard

## Stap 1: Toegang tot het Dashboard

1. **Open het Wazuh-dashboard**:
   - Ga naar de URL van je Wazuh-dashboard in je webbrowser. Dit is meestal iets als `https://<wazuh-server-ip>:443/`.

2. **Log in**:
   - Voer je gebruikersnaam en wachtwoord in om in te loggen op het dashboard.

## Stap 2: Agent Registratie Initiëren

1. **Ga naar de Agents sectie**:
   - Klik in het menu aan de linkerkant op `Management` en vervolgens op `Agents`.   
2. **Voeg een nieuwe agent toe**:
   - Klik op de knop `Add agent` (of `+ Add`).

## Stap 3: Selecteer de Besturingssysteem van de Agent

1. **Selecteer het juiste besturingssysteem**:
   ![part1 agent](https://github.com/michaelthielemans/ProjectHosting/assets/118989454/f32a4269-e8c6-4973-a1a5-295406a650c4)

2. **Geef het correcte ip van de manager**:
   ![ip agent](https://github.com/michaelthielemans/ProjectHosting/assets/118989454/2d9acb8d-639e-4dbc-9a6f-e40295d79d84)
   
4. **Assign an agent name**:
   ![agent name](https://github.com/michaelthielemans/ProjectHosting/assets/118989454/b18efaa6-6fb6-4174-bb56-2492878001f4)



## Stap 4: Installeer en Configureer de Agent op de Doelmachine

1. **Voer de installatie-instructies uit**:
   - Log in op de machine waarop je de agent wilt installeren.
   - Open een terminal (of command prompt voor Windows) en voer de gekopieerde installatie-instructies uit. Dit omvat meestal het downloaden en installeren van het Wazuh-agentpakket, evenals het configureren van de agent om verbinding te maken met je Wazuh-server.
     ![commands agent](https://github.com/michaelthielemans/ProjectHosting/assets/118989454/d516cb47-03db-48ab-ad56-1f46b7e6de40)



2. **Enable de service agent**
![stap5 agent](https://github.com/michaelthielemans/ProjectHosting/assets/118989454/8cb8074e-3439-40f0-be74-ce6673adb995)


## Stap 5: Controleer de Verbinding

1. **Verifieer de agent status**:
   - Ga terug naar het Wazuh-dashboard en verifieer of de nieuwe agent is toegevoegd en correct verbinding maakt. De agent zou moeten verschijnen in de lijst van agents met een status die aangeeft dat hij actief is.

2. **Controleer logs en statistieken**:
   - Controleer de logs en statistieken van de agent om er zeker van te zijn dat alles correct werkt.

## Optionele Stap: Configuratie van Agentgroepen

1. **Agentgroepen toewijzen**:
   - Indien gewenst, kun je de agent toewijzen aan specifieke groepen voor eenvoudiger beheer en monitoring.

Door deze stappen te volgen, kun je eenvoudig een nieuwe agent toevoegen aan je Wazuh-dashboard via de webinterface.
