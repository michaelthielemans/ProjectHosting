Wazuh Installatiehandleiding
Deze handleiding zal je helpen bij het opzetten van een Wazuh-cluster met één master-node en twee worker-nodes. Volg deze stappen om Wazuh te installeren en configureren.

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
