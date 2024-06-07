![image](https://github.com/michaelthielemans/ProjectHosting/assets/119003253/6ce42726-73f1-466c-9075-a90863f076e0)

Beheerder : Janssen Niels

Verantwoordelijke : Janssen Niels

## 1. Table of Contents 

| Navigation |             
| :-------------------------------------------------  |
| [1. Table of Contents](#1-table-of-contents)             |
| [2. Overview](#2-minimum-hardware-requirements)  |
| [3. Procedure](#3-procedure)                     |
| [4. Download TrueNAS scale](#4-download-truenas-scale)       |
| [5. Install TrueNAS scale](#5-install-truenas-scale)         |
| [5.1 Virtual Machine overview](#51-virtual-machine-overview)     |
| [5.2 TrueNAS Installer](#52-truenas-installer)           |
| [6. TrueNAS WebInterface](#6-truenas-webinterface)         |

## 2. Overview

## 3. Prerequisites

## 4. Procedure

1.	Zoek of maak een Docker image
2.	Installeer alle nodige software
3.	Check voor vulnerabilities
4.	Patch de vulnerabilities
5.	Save Docker image & upload deze naar de Dockerhub
6.	Enable & monitor vulnerabilities -> Docker Scout Image Analysis
7.	Schrijf de docker-compose.yaml

## 5. Execution 

### 5.1 Docker image maken

```Docker pull yobasystems/alpine-mariadb```

```Docker pull yobasystems/alpine-php-wordpress```

```Docker images -> copy image id```

```Docker run -d <image-id>``` 

```Docker scout cves```

```Docker exec -it <Container-id> /bin/bash```

Maak nu alle nodige aanpassingen aan de image en patch de vulnerabilities waar mogelijk

![image](https://github.com/michaelthielemans/ProjectHosting/assets/119003253/d102250a-ae43-4f46-937f-7cb12b692f76)

### 5.2 Save Docker image

```Docker commit <container-id> wordpress-nodb```

```Docker tag wordpress-nodb bloedlink/wordpress-nodb:latest```

```Docker push bloedlink/wordpress-nodb:latest```


### 5.3 Docker Scout Image Analysis

Deze Docker feature geeft automatisch weer als er vulnerabilities aanwezig zijn in de Docker image

![image](https://github.com/michaelthielemans/ProjectHosting/assets/119003253/63ef4fb0-4017-4ecb-8fa1-d88ba8fb97cf)

De feature kan in de gratis versie van Docker op maximaal 3 images geactiveerd worden.

Om deze feature te activeren, ga je naar de Docker image onder jouw profiel op de Dockerhub. Onder settings vink de optie “Docker Scout Image Analysis” aan

![image](https://github.com/michaelthielemans/ProjectHosting/assets/119003253/0216cb86-b775-4276-a4c6-dd248f1927ce)


### 5.4 Docker file 
```
version: '3.8'
services:
  wordpress:
    image: bloedlink/wordpress-nodatabase
    container_name: wp-wordpress
    ports:
      - "8000:80"
    environment:
      WORDPRESS_DB_HOST: db
      WORDPRESS_DB_USER: db-user
      WORDPRESS_DB_PASSWORD: yGzZqJKD4YzZMRtskmopQa
      WORDPRESS_DB_NAME: wordpress-db
    volumes:
      - wordpress_data:/usr/html/
      - ./plugins:/var/www/html/wp-content/plugins
    depends_on:
      - db
  db:
    image: yobasystems/alpine-mariadb
    container_name: wp-mariadb
    environment:
      MYSQL_ROOT_PASSWORD: HDt24a7W2kow6XQsxequyR
      MYSQL_DATABASE: wordpress-db
      MYSQL_USER: db-user
      MYSQL_PASSWORD: yGzZqJKD4YzZMRtskmopQa
    volumes:
      - mysql_data:/var/lib/mysql

volumes:
  wordpress_data:
  mysql_data:
```

### 5.5
