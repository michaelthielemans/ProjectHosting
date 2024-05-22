#documentation
## Semaphore is graphical interface on top of ansible.


|[Installation](Ansible/semaphore/Installation.md) |
| [Configure sempaphore](Configuration.md) |
Interface is available at [http://172.24.1.75:3000](http://172.24.1.75:3000)

In the interface you can manage Tasks, inventories, keys, repositories ( local or git)

A Task is a action where you define:
> What (playbook) , to which servers (inventory) and when (manual or cron) need to be executed

Drop all the playbooks in yml format on the repo (github) during a task
