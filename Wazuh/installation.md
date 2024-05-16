
![wazuh-logo-main-02](https://github.com/michaelthielemans/ProjectHosting/assets/118989454/64aa9a11-f322-4818-909e-62e68ac4a955)


Wazuh Installatiehandleiding voor het opzetten van een Wazuh-cluster met één master-node en twee worker-nodes. (2 servers / 3 indexers / 2 dashboards)

<br/>1. Maak de map en download bestanden
````bash
sudo mkdir wazuh
cd wazuh
sudo curl -sS https://packages.wazuh.com/4.7/wazuh-install.sh -o wazuh-install.sh
sudo curl -sS https://packages.wazuh.com/4.7/config.yml -o config.yml
````

<br/>2. Bewerk het config.yml-bestand om je nodes te configureren.
```yaml
nodes:
  # Wazuh indexer nodes
  indexer:
    - name: wazuh-1
      ip: "172.24.1.81"
    - name: wazuh-2
      ip: "172.24.1.82"
    - name: wazuh-3
      ip: "172.24.1.83"

  # Wazuh server nodes
  server:
    - name: wazuh-1
      ip: "172.24.1.81"
      node_type: master
    - name: wazuh-2
      ip: "172.24.1.82"
      node_type: worker

  # Wazuh dashboard nodes
  dashboard:
    - name: wazuh-1
      ip: "172.24.1.81"
    - name: wazuh-2
      ip: "172.24.1.82"
````

<br/>3. Genereer het .tar Configuratiebestanden
````bash
sudo bash wazuh-install.sh --generate-config-files --ignore-check
````

<br/>4. Voer dit commando uit op alle andere nodes om het gegenereerde tar-bestand over te zetten naar andere nodes
````bash
sudo scp master@test-vm-masternode-01:/home/master/wazuh/wazuh-install-files.tar ~/wazuh/
````

<br/>5.	Verander de permissies op alle nodes
````bash
sudo chmod 744 wazuh-install-files.tar
````

<br/>6.	Activeer de indexers (Op alle indexer nodes)
````bash
sudo bash wazuh-install.sh --wazuh-indexer wazuh-1 --ignore-check
sudo bash wazuh-install.sh --wazuh-indexer wazuh-2 --ignore-check
sudo bash wazuh-install.sh --wazuh-indexer wazuh-3 --ignore-check
````

<br/>7.	Activeer de cluster (Op de master alleen)
````bash
sudo bash wazuh-install.sh --start-cluster --ignore-check
````

<br/>8.	Haal de inlog gegevens uit de .tar file
````bash
tar -axOf wazuh-install-files.tar wazuh-install-files/wazuh-passwords.txt | grep -A 1 "admin"
````
![user-pasw](https://github.com/michaelthielemans/ProjectHosting/assets/118989454/c534e2f1-16f8-4d71-87fe-6ed83d6bd0fe)





<br/>9.	Test de inlog gegevens
````bash
sudo curl -k -u admin:<password> https:// 172.24.1.81:9200
````
![logintest](https://github.com/michaelthielemans/ProjectHosting/assets/118989454/e9ec901b-8042-4237-9b14-7752a2cd5b65)

<br/>10.	Nodes bekijken
````bash
curl -k -u admin:curl -k -u admin:<password> https://172.24.1.81:9200/_cat/nodes?v
````
![nodes actief](https://github.com/michaelthielemans/ProjectHosting/assets/118989454/65b73668-f35c-4f25-998b-4e44f681ae78)



<br/>11.	 Wazuh server opstarten
````bash
sudo bash wazuh-install.sh --wazuh-server wazuh-1 --ignore-check
sudo bash wazuh-install.sh --wazuh-server wazuh-2 --ignore-check
````

<br/>12.	Wazuh dashboard opstarten
````bash
sudo bash wazuh-install.sh --wazuh-dashboard wazuh-1 --ignore-check
sudo bash wazuh-install.sh --wazuh-dashboard wazuh-2 --ignore-check
````

<br/>Eventueel andere port-number
````bash
sudo bash wazuh-install.sh --wazuh-dashboard wazuh-1 -p <port-number>
````
