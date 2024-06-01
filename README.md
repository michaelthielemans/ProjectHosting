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

| **Silo**               | **Technology**           | **Responsible**  |
|------------------------|--------------------------|-----------|
| HyperVisor             | VMWARE                   | Michael   |
| Cluster                | Kubernetes               | Michael   |
| Storage                | TrueNAS                  | Niels     |
| DNS                    | Cloudflare               | Niels     |
| Password vault         | Vaultwarden              | Niels     |
| Security               | WAZUH                    | Dieter    |
| Backups                | TrueNAS                  | Niels     |
| Automation Platform    | ansible (+ puppet)       | Michael   |
| Docker + K8S Webstack  | Docker / YAML            | Niels     |
| Procedures and Compliance | ...                   | ...       |
| Documentation          | Github                   | ALL       | 
| Monitoring             | Prometheus - Grafana     | Wim       |
| Logging                | ...                      | ...       | 

# Conventions

### **Attention: NEVER EVER save login credentials or secrets in this repository.**

## Documentation
- Write documentation in Markdown

## Types of Webshops
- Small
- Medium
- Large -> more resources -> more replicas
