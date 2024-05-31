# Ansible automation platform

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
Semaphore official documentation https://docs.semui.co

### Team Roles
Een andere functionaliteit die semaphore aanbied is het aanmaken van 'Team members' en daaraan 'Roles' te koppelen. Hierdoor kunnen er meerdere gebruikers toegang krijgen met elk hun bevoegdheden. Bijvoorbeeld is er een rol die het enkel mogelijk maakt om templates uit te voeren.
![teamroles](https://github.com/michaelthielemans/ProjectHosting/blob/main/images/semaphore-teamroles.png)

### Templates
In een template komen alle voorafgaande functionaliteiten samen, een template bevat alle nodige configuratie en koppelingen om een actie te kunnen uitvoeren op een target.
Op deze pagina kan je een overzich terug vinden van alle aangemaakte templates en hun status.
![templates](https://github.com/michaelthielemans/ProjectHosting/blob/main/images/semaphore-templates.png)

![template](https://github.com/michaelthielemans/ProjectHosting/blob/main/images/semaphore-template.png)

## Installatie
Semaphore is geinstalleerd in een container op een apparte virtuele machine. De semaphore container bevat zowel de user interface alsook ansible zelf. Installatie procedure is beschikbaar op de officiele documentatie. https://docs.semui.co/administration-guide/installation#docker
We hebben gekozen om gebruik te maken van een docker compose file om de semphore container te installeren.


## Playbooks
- written in .yaml files
- defines WHAT has to be applied to a device

## Inventory
- A list of devices divided into groups

## Module
- a piece of extra code that will make it possible that ansible can translate WHAT needs to be changed into effectively connecting to the device and adjust the configuration if needed.



## Ansible execution environment
### Tools needed to create an environment:
  - cli tool : ansible builder
     this tool will create the software package based on requirements.yml , requirements.txt
  - podman/docker to build the image
  -   
