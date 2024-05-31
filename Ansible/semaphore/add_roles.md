# adding roles to ansible semaphore
When semaphore is deployed inside a container you need to restart the container with a specific requirements.yaml file


## adding

## installing prometheus.prometheus role


---
collections:
  - 'prometheus.prometheus'
  # for common collections:
  - 'community.general'
  - 'ansible.posix'
  - 'community.mysql'
  - 'community.crypto'

roles:
  - src: 'namespace.role'
