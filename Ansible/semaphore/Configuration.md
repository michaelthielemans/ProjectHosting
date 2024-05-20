# Configuring semaphore

Once semaphore is installed you can start the configuration in the following order:
1. The interface will prompt you to create a new project
2. Create Keys
3. Create an Inventory
4. Connect a Repository
5. Create a Task Template

## 1. A new project
use a unique name for it.
## 2. Create keys and logins
Before you can connect to the remote targets you have to create new SSH keys. The server need a private key and the remote target needs to have the public key part of the keypair. the keypair will provide authentication and encryption
### 2.1 Create ssh-key 
#### 2.1.A Generate a SSH private/public keypair.
This can be done on you local machine or on the semaphore server itself, it doesn't matter where you create the keypair.
- ` ssh-keygen`
  > This is the tool to generate keypairs , extra parameters can be set if needed.  If you want to change the key type use -t <keytype>  for example `ssh-keygen -t rsa`
- Enter file name / location
  > this is the location where the key will be stored, you can leave it to default, also the location is not if great importance because the private key will enventually be entered in the semaphore web ui and the public part will be copied to the remote targets.
- ` enter passphrase `
  > Is optional if you use a passphrase you need to add this passphrase to the semaphore ui when entering a new ssh key

#### 2.1.B. Copy the public part of the keypair to the remote targets
`ssh-copy-id -i ~/.ssh/id_rsa.pub master@172.24.1.105
> copy the pub key to the authorizers of the master
> After finishing this command the pub key will be added to the /home/master/.ssh/authorized_keys file. It will copy the key to the home dir location of the users from where you started the ssh session
> -> If a machine will connect to the remote with a ssh key, the remote will check if he has a corresponding public key available in one of his authorized_keys files. Depending on the location of this public key the session will be bound to that user.

#### 2.1.C. Add the private key to the key store in semaphore
1. Open key store
2. New key:
   > Type = SSH key
   > username = leave blank
   > passphrase = if you added one during keypair creation
   > paste in the private key into the field

### 2.2 Create logins
If you need to have sudoers permissions
#### 2.2.A add a new key 
> select login with password
> ⁉️Leave the password blank -> this is a known bug, because you already connecting over ssh key that is linked to a user you don't need to add it again in here.
> Enter the password of the account that you want to use on the remote targets
#### 2.2.B add the used account on the remote targets to the sudoers file.
` sudo vim /etc/sudoers.d/<username>`
add the following line to the file
` <username> ALL=(ALL) NOPASSWD: ALL`

### 3. Create an Inventory

1. add inventory
2. Usercredentials -> select the ssh key you added before
3. Sudo credentials -> select the login with password entry you added before
4. add a list of ip's

### 4. Connect a repository
1. Create a new github repo and copy the https:// link
2. paste the link
3. Branch -> main
4. access key => none if the repo is public

### 5. Create a Task Template
- Playbook filename = the name of the file you added to the github repository
- environment = empty
- vault = leave empty
