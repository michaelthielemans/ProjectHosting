# Hi, this is HostHive Hosting

[![Our Website](https://img.shields.io/static/v1?label=Our&message=Website&color=blue)](http://172.24.1.81:30080)

## Quick Links
- [IP Plan](IPplan/ip.md)
- [Conventions](#conventions)

# Our Team

- Dieter Verbeek
- Jakub Rzeczkowski
- Michael Thielemans
- Niels Janssen
- Wim Heyns

# Responsibility Silos

| **Silo**               | **Technology**           | **Lead**  | **Support** |
|------------------------|--------------------------|-----------|-------------|
| HyperVisor             | VMWARE                   | Michael   | Niels       |
| Cluster                | Kubernetes               | Michael   | Niels       |
| Storage                | TrueNAS                  | Niels     |             |
| DNS                    | ...                      | ...       |             |
| Mailserver             | ...                      | ...       |             |
| Security               | WAZUH                    | Dieter    |             |
| Backups                | VSphere + TrueNAS        | Niels     | Michael     |
| Ticketing              | FreeScout HelpDesk       | Jakub     |             |
| Automation Platform    | ansible (+ puppet)       | Michael   |             |
| Docker Images / Webstacks | Docker - LAMP        | Niels     |             |
| Procedures and Compliance | ...                  | ...       |             |
| Documentation          | Github                   | ALL       |             |
| Monitoring             | Prometheus - Grafana     | Wim       | Michael     |
| Logging                | ...                      | ...       | ...         |

# Conventions

### **Attention: NEVER EVER save login credentials or secrets in this repository.**

## Documentation
- Write documentation in Markdown

## Types of Webshops
- Small
- Medium
- Heavy -> more resources -> more replicas
