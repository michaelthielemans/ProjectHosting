apiVersion: apps/v1
kind: Deployment
metadata:
  name: lemp-stack
spec:
  replicas: 3
  selector:
    matchLabels:
      app: lemp-stack
  template:
    metadata:
      labels:
        app: lemp-stack
    spec:
      containers:
        - name: nginx
          image: nginx:latest
          ports:
            - containerPort: 80
        - name: php-fpm
          image: php:7.4-fpm
        - name: mariadb
          image: mariadb:10.2
          env:
            - name: MYSQL_ROOT_PASSWORD
              value: your-root-password
            - name: MYSQL_DATABASE
              value: your-database-name
            - name: MYSQL_USER
              value: your-username
            - name: MYSQL_PASSWORD
              value: your-password
