# Network Zones

These are the zones that exist today. Planned zones are listed separately.

| Zone | What lives there | Trust level |
|---|---|---|
| Home main network | XPS 16, Surface Book 3, iPhones, tablet | Trusted |
| Home guest network | Samsung Galaxy S5, other untrusted devices | Untrusted |
| AD lab (host-only, `corp.lab`) | DC01, CLIENT01, LOGSRV, Kali | Isolated lab |
| SOC lab (VirtualBox) | Windows 11 Enterprise VM, Ubuntu VM | Isolated lab |
| Tailnet | XPS 16, phone, other enrolled devices | Trusted, authenticated |
| AWS | CloudHub, monitoring server | Internet-facing, controlled by security groups |
| Azure | Windows 10 honeypot, Log Analytics, Sentinel | Honeypot is intentionally exposed — untrusted, isolated in its own resource group |
| Docker (local) | ELK stack, sys-exp, docker-exp, pqc-poc, Gitea | Local only; sys-exp agents reachable over Tailscale |
| GCP (planned) | pqc-poc VMs in two regions | Controlled by VPC firewall rules |

## Rules of thumb

- Lab VMs never get a direct path to the home main network.
- Kali lives only on the AD lab network — never in the services lab.
- Nothing on the guest network is used for real accounts.
- Services I depend on stay on a different host from destructive testing.

## Planned

| Zone | What will live there | Trust level |
|---|---|---|
| Services lab (Surface Book 3, Hyper-V NAT `10.10.20.0/24`) | Proxmox VE, Debian Docker VM: Nginx Proxy Manager, Uptime Kuma, a daily-use service | Trusted services; outbound through Windows NAT, reached over Tailscale |
| Services lab LAN (Phase 2, behind OPNsense) | Management and internal-only services: Proxmox UI, Authentik, CA | Trusted, admin only |
| Services lab DMZ (Phase 2, behind OPNsense) | The reverse proxy and anything it publishes to the tailnet | Semi-trusted; can't start connections into the LAN |

- Dedicated VLANs once a managed switch is added.
- A DNS filtering zone once Pi-hole is running.
