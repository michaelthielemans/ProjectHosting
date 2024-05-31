# Ansible automation platform met Semaphore

Semaphore official documentation https://docs.semui.com

Om taken te automatiseren maken we gebruik van ansible met semaphore. Semaphore is een user interface bovenop ansible, dit maakt het gebruik van ansible visueler en gebruiksvriendelijker.
## Semaphore functionaliteiten:

### Inventory
Net zoals in ansible is het mogelijk om een inventory aan te maken. Een inventory is een lijst waarin je de machines kan specifieren die je later wil gebruiken als target voor je playbooks.
![inventory](https://github.com/michaelthielemans/ProjectHosting/blob/main/images/semaphore-inventory.png)

### Key Store
Hierin kunnen alle login credentials en ssh keys worden opgeslagen die ansible kan gebruiken om plays uit te voeren.
![keystore](https://github.com/michaelthielemans/ProjectHosting/blob/main/images/semaphore-keystore.png)

### Repository
Op de repository pagina kan er een link gecreeerd worden met een github repository. Dit maakt het mogelijk om playbook yaml files die opgeslagen en beheerd worden op github te laten gebruiken door semaphore. Voor ons project is er een apparte github repository aangemaakt waarop al onze playbooks staan opgeslagen.
![repository](https://github.com/michaelthielemans/ProjectHosting/blob/main/images/semaphore-repository.png)

### Playbooks
Zoals hierboven reeds beschreven bevinden onze playbooks zich op de github repository. Een playbook is in essentie een .yaml file die de taak of taken 'plays' beschrijft die moeten worden uitgevoerd op een target machine. Elke taak een play genaamd roept een module op die de syntax van de play omvormt naar een commando dat dient uitgevoerd te worden op de target machine. Out-of-the-box bevat ansible al een hele resem aan modules maar het is ook mogelijk om extra modules toe te voegen aan ansible. Dit maakt ansible een enorm veelzijdige automation tool.

### Team Roles
Een andere functionaliteit die semaphore aanbied is het aanmaken van 'Team members' en daaraan 'Roles' te koppelen. Hierdoor kunnen er meerdere gebruikers toegang krijgen met elk hun bevoegdheden. Bijvoorbeeld is er een rol die het enkel mogelijk maakt om templates uit te voeren.
![teamroles](https://github.com/michaelthielemans/ProjectHosting/blob/main/images/semaphore-teamroles.png)

### Templates
In een template komen alle voorafgaande functionaliteiten samen, een template bevat alle nodige configuratie en koppelingen om een actie te kunnen uitvoeren op een target.
Op deze pagina kan je een overzich terug vinden van alle aangemaakte templates en hun status.
![templates](https://github.com/michaelthielemans/ProjectHosting/blob/main/images/semaphore-templates.png)

![template](https://github.com/michaelthielemans/ProjectHosting/blob/main/images/semaphore-template.png)

## Installatie van Semaphore + ansible
Semaphore is geinstalleerd in een container op een apparte virtuele machine. De semaphore container bevat zowel de user interface alsook ansible zelf. Installatie procedure is beschikbaar op de officiele documentatie. https://docs.semui.co/administration-guide/installation#docker
We hebben gekozen om gebruik te maken van een docker compose file om de semphore container te installeren op de managment VM.

