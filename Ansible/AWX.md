# AWX documentations

## Template
A template or job template is a blueprint for jobs.
It will hold the configuration to :
- TARGET -> define the inventory
- What -> define the project which holds the platbook
- which Execution Environment it need to use.

## Projects
The projects holds the playbooks it needs to run

## Execution Environment
The default ansible EE is allready installed by default
You can add purpose build EEs to AWX
A Execution Environment is a separate container containing the ansible core + all the necessary dependencies needed to run the specific playbooks.

### Create a execution environment
1. install ansible builder -> cli tool that will work in conjunction with podman/docker to build the image
2. write requirements.txt, requirement.yml
3. build the image
4. upload the image to a private or public container registry
5. insert the image to AWX via the webui