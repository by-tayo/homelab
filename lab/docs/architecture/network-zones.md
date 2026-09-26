# Network Zones

These are the zones that exist today. Planned zones are listed separately.

| Zone | What lives there | Trust level |
|---|---|---|
| Home main network | XPS 16, Surface Book 3, iPhones, tablet | Trusted |
| Home guest network | Samsung Galaxy S5, other untrusted devices | Untrusted |
| AD lab (host-only, `corp.lab`) | DC01, CLIENT01, LOGSRV, Kali | Isolated lab |
| SOC lab (VirtualBox) | Windows 11 Enterprise VM, Ubuntu VM | Isolated lab |
| Tailnet | XPS 16, phone, other enrolled devices | Trusted, authenticated |
| AWS | CloudHub, monitoring server, ELK SOC | Internet-facing, controlled by security groups |
| Azure | Windows 10 honeypot, Log Analytics, Sentinel | Honeypot is intentionally exposed — untrusted, isolated in its own resource group |
| GCP | PQC TLS POC instances | Controlled by VPC firewall rules |

## Rules of thumb

- Lab VMs never get a direct path to the home main network.
- Kali lives only on the AD lab network.
- Nothing on the guest network is used for real accounts.

## Planned

- Dedicated VLANs once a managed switch is added.
- A DNS filtering zone once Pi-hole is running.
