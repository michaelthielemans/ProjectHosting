# Ansible automation platform

## Architecture


## Playbooks
- written in .yaml files
- defines WHAT has to be applied to a device

## Inventory
- A list of devices divided into groups

## Module
- a piece of extra code that will make it possible that ansible can translate WHAT needs to be changed into effectively connecting to the device and adjust the configuration if needed.

## Ansible installed as a container in kubernetes


## Tips
- use VS Code ansible extension for writing playbooks


## Ansible execution environment
### Tools needed to create an environment:
  - cli tool : ansible builder
     this tool will create the software package based on requirements.yml , requirements.txt
  - podman/docker to build the image
  -   
