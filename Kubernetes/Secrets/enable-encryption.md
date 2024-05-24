# How to encrypt the secrets stored in etcd data store
By default the secrets are encoded with base64 in the etcd data store.

## Procedure
1. Generate a encryption key
2. Create a encryption definitions manifest
3. Save the Encryption Configuration File
4. Edit the api-server manifest file

## 1. genereate the encryption key
this key is used to encrypt the data
create it with the following command
```
head -c 32 /dev/urandom | base64
```

## 2. Encryption definitions manifest file
```
kind: EncryptionConfiguration
apiVersion: apiserver.config.k8s.io/v1
resources:
  - resources:
      - secrets
    providers:
      - aescbc:
          keys:
            - name: key1
              secret: <YOUR_BASE64_ENCODED_KEY>
      - identity: {}
```

## 3. Save the Encryption Configuration File
- Save the encryption-config.yaml file to a secure location on your master node, for example, /etc/kubernetes/encryption-config.yaml

## 4. edit the api-server manifest file
The manifest file that contains all the configuration applied to the api-server is located at:
`/etc/kubernetes/manifests/kube-apiserver.yaml

add the following line to the file
`- --encryption-provider-config=/etc/kubernetes/encryption-config.yaml
