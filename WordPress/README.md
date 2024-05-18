# WordPress Implementatie Documentatie

**Beheerder**: Jakub Rzeczkowski  
**Verantwoordelijke**: Jakub Rzeczkowski

## 1. Inhoudsopgave

| Navigatie |             
| :---------------------------------------------  |
| [1. Inhoudsopgave](#1-inhoudsopgave)           |
| [2. IP-adressen](#2-ip-adressen)               |
| [3. Implementatie Details](#3-implementatie-details) |
| [4. Toegangsgegevens](#4-toegangsgegevens)     |
| [5. Handleiding](#5-handleiding)               |
| [5.1 Kubernetes Configuratie](#51-kubernetes-configuratie) |
| [5.2 Implementatie van WordPress](#52-implementatie-van-wordpress) |

## 2. IP-adressen

| Rol     | IP-adres        | Poort  |
| ------- | ---------------- | ------ |
| Master  | 172.24.1.81      | 30080  |

## 3. Implementatie Details

- **WordPress Versie**: 6.5.3
- **MySQL Versie**: 8.4
- **PHP Versie**: 8.3
- **Geïnstalleerde Plugins**: User Registration
- **Gebruikt Thema**: Raft
- **Locatie Implementatiebestand**: GitHub en Jakub's NFS-share (Opmerking: WordPress-bestanden zijn momenteel opgeslagen in Jakub's NFS-share)

## 4. Toegangsgegevens

- **URL**: [http://172.24.1.81:30080](http://172.24.1.81:30080)
- **Administrator Login**: `admin`
- **Administrator Wachtwoord**: `admin`
- **Gebruikersregistratie**: Gebruikers kunnen zich registreren via het registratieformulier dat door de User Registration-plugin wordt geleverd.

## 5. Handleiding

### 5.1 Kubernetes Configuratie

1. **Kubernetes Cluster Configureren**
   - Zorg ervoor dat je Kubernetes-cluster correct is geconfigureerd en actief is.
   - Verplaats de WordPress-deployment naar een workernode in plaats van de masternode.

2. **NFS-share Configureren**
   - Zorg ervoor dat de NFS-share toegankelijk is en correct is aangekoppeld in je Kubernetes-cluster.

### 5.2 Implementatie van WordPress

1. **Voorbereiden van Implementatiebestanden**
   - Verkrijg de deployment van Jakub's NFS-share.
   - Maak indien nodig de benodigde aanpassingen aan de deployment bestand.

2. **Implementeer WordPress op Kubernetes**
   - Pas de deployment ebestand toe met behulp van kubectl:
     ```bash
     kubectl apply -f /path/to/deployment-file.yaml
     ```
   - Verifieer de implementatie:
     ```bash
     kubectl get pods
     ```

3. **Toegang tot WordPress**
   - Open je webbrowser en navigeer naar [http://172.24.1.81:30080/login/](http://172.24.1.81:30080/login/).
   - Log in als administrator met de verstrekte inloggegevens (`admin:admin`).
   - Gebruikers kunnen zich registreren voor hun eigen accounts via het registratieformulier op de site.

### 5.3 Bijwerken van Implementatie

1. **Wijzig Implementatieconfiguratie**
   - Bewerk de deployment file om instellingen of configuraties bij te werken.

2. **Pas Wijzigingen Toe**
   - Pas het bijgewerkte deployment file opnieuw toe:
     ```bash
     kubectl apply -f /path/to/deployment-file.yaml
     ```

## 6. Probleemoplossing

- **Veelvoorkomende Problemen**:
  - Zorg ervoor dat de Kubernetes-clusternodes voldoende middelen hebben.
  - Verifieer dat de NFS-share correct is aangekoppeld en toegankelijk is.
  - Controleer de pod-logs op eventuele fouten:
    ```bash
    kubectl logs <pod-naam>
    ```
