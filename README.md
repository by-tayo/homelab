# The Lab

Everything I run, build, break, and fix — from cloud infrastructure to the
hardware on my desk to the software tying it together. This repo is the map:
it documents the whole environment and links out to the deep-dive project repos.

I'm learning in public, one day at a time. The [`journal/`](journal/) folder is
the honest record: what I set up, what broke, how I fixed it, and what I learned.

> [!IMPORTANT]
> Everything I test here runs on hardware I own or VMs I built myself. The
> techniques come from public learning material. Please don't point them at
> anything you don't have permission to touch.

## Objectives

- Run and document real infrastructure across three clouds (AWS, Azure, GCP), on-prem hardware, and virtual labs.
- Practice Windows enterprise skills — Active Directory, Group Policy, Sysmon, Windows Event Logs.
- Collect and investigate security telemetry with Splunk, the ELK Stack, and Microsoft Sentinel.
- Test post-quantum cryptography (ML-DSA certificates, ML-KEM key exchange) in real TLS handshakes.
- Practice networking: routing, DNS, DHCP, firewalls, VPNs, segmentation, and traffic analysis.
- Run attacks in an isolated lab and prove they are detected.
- Treat mobile and legacy devices as real endpoints to monitor and isolate.
- Document decisions, failures, and fixes as I go.

## The environment at a glance

```text
  ┌──────────── AWS ────────────┐ ┌──── Azure ─────┐ ┌──── GCP ──────┐
  │ CloudHub (Nextcloud)        │ │ Sentinel SIEM  │ │ PQC TLS POC   │
  │ Monitoring server           │ │ + honeypot VM  │ │ (ML-DSA certs)│
  │ ELK Stack SOC               │ │                │ │               │
  └──────────────┬──────────────┘ └───────┬────────┘ └──────┬────────┘
                 └─────────────────────────┼─────────────────┘
                                           │
                                       │  Tailscale (private tunnel)
Internet ── TP-Link Archer AX6000 ─────┤
               │            │          │
          main network   guest network │
               │            │          │
   Dell XPS 16 (hypervisor) │     Samsung Galaxy S5
   Surface Book 3           │     (untrusted legacy device)
   iPhones / tablet ────────┘
               │
   XPS 16 virtual lab (host-only, behind virtual pfSense)
     └─ corp.lab: DC01 · CLIENT01 · LOGSRV (Splunk) · Kali
```

Full design: [architecture overview](docs/architecture/overview.md) ·
[network zones](docs/architecture/network-zones.md) ·
[IP plan](docs/architecture/ip-address-plan.md)

## Hardware

| Device | Role |
|---|---|
| Dell XPS 16 9640 (Core Ultra 9 185H, 32 GB RAM) | Primary hypervisor host — VMware Workstation Pro and VirtualBox lab VMs; runs the Windows Command Center agent |
| Microsoft Surface Book 3 | Second workstation — analysis, documentation, packet capture, remote admin |
| TP-Link Archer AX6000 | Home edge router — main and guest networks |
| iPhones | Mobile endpoints — traffic-monitoring subjects and Tailscale clients |
| Tablet (TODO: model) | Mobile endpoint |
| Samsung Galaxy S5 | Unsupported legacy Android device, isolated on the guest network for capture and isolation exercises |

Full list: [asset inventory](docs/hardware/asset-inventory.md) ·
planned additions: [procurement roadmap](docs/hardware/procurement-roadmap.md)

## Core software

| Component | Role |
|---|---|
| VMware Workstation Pro 17 | Hosts the Active Directory lab |
| Oracle VirtualBox | Hosts the SOC lab |
| pfSense CE (virtual) | Router, DHCP, and firewall for the AD lab network |
| Windows Server 2022 | Domain controller — AD DS and DNS |
| Windows 11 | Domain-joined endpoint and SOC lab endpoint |
| Ubuntu / Rocky Linux | Linux servers on-prem and in AWS |
| Splunk Enterprise + Universal Forwarder | SIEM for the AD and SOC labs |
| Sysmon (SwiftOnSecurity config) | Windows endpoint telemetry |
| ELK Stack | SOC stack in AWS |
| Microsoft Sentinel + Log Analytics | Cloud SIEM for the Azure honeypot lab; queried with KQL |
| OpenSSL + gcloud CLI | PQC TLS handshake testing in GCP |
| Wireshark | Packet capture and TLS handshake inspection |
| Kali Linux | Isolated attack box |
| Tailscale | Private remote access — no admin interfaces exposed publicly |
| Docker Desktop | Local containers (Gitea, BloodHound CE) |

## Projects

| Project | Where | Summary |
|---|---|---|
| [Active Directory lab](labs/ad-homelab.md) | XPS 16 · VMware | DC, domain-joined client, GPOs, pfSense, Splunk telemetry, Kerberoasting attack + detection |
| [SOC lab](labs/soc-lab.md) | XPS 16 · VirtualBox | Windows 11 Enterprise + Ubuntu, Splunk SIEM, mobile monitoring next |
| [CloudHub](labs/cloudhub.md) | AWS EC2 | Self-hosted Nextcloud; TrueNAS integration planned |
| [AWS monitoring server](labs/aws-monitoring.md) | AWS | TODO |
| [ELK Stack SOC](labs/elk-soc.md) | AWS | TODO |
| [SIEM simulation](labs/azure-siem-simulation.md) | Azure | Exposed Windows 10 honeypot, logs into Microsoft Sentinel via Log Analytics, KQL queries, GeoIP live attack map |
| [PQC TLS POC](labs/gcp-pqc-poc.md) | GCP | TLS handshakes with ML-DSA-65/87 certificates and hybrid ML-KEM key exchange — in progress |
| [Windows Command Center](labs/windows-command-center.md) | XPS 16 + Tailscale | Phone dashboard and control panel for the XPS 16 |
| [no-brainer](labs/no-brainer.md) | Local | Self-hosted note-taking stack — Obsidian, Gitea, MCP |

## Repository map

- [`docs/architecture/`](docs/architecture/) — overview, network zones, IP plan
- [`docs/hardware/`](docs/hardware/) — what I own, and what I plan to add
- [`docs/security/`](docs/security/) — segmentation, access control, threat model
- [`docs/operations/`](docs/operations/) — backups, patching, monitoring
- [`labs/`](labs/) — one summary per project, linking to its repo
- [`runbooks/`](runbooks/) — repeatable step-by-step procedures
- [`journal/`](journal/) — dated build / break / fix notes
- [`infrastructure/`](infrastructure/) and [`automation/`](automation/) — configs and scripts as they're built

## Security principles

- No administrative interface (RDP, SSH, dashboards, hypervisor) exposed to the public internet.
- Remote access only over Tailscale.
- Attack tooling and intentionally weak systems live only on isolated host-only lab networks.
- Untrusted and legacy devices stay on the guest network.
- Secrets never go into Git — only sanitized examples. See [SECURITY.md](SECURITY.md).
- Snapshots before risky changes; restores get tested, not assumed.

## Roadmap

**Now**
- [ ] Document each device and the real network topology
- [ ] Harden and document the AX6000 ([runbook](runbooks/router-hardening.md))
- [ ] Mobile-device traffic monitoring in the SOC lab
- [ ] First real run of Windows Command Center on the XPS 16

**Next**
- [ ] Revisit the Azure SIEM honeypot lab
- [ ] Add TrueNAS and connect it to CloudHub
- [ ] Pi-hole DNS on a Raspberry Pi 4
- [ ] Backup and restore tests for the VM labs

**Later**
- [ ] Dedicated always-on hypervisor host (Proxmox)
- [ ] Managed switch and real VLANs
- [ ] Configuration automation with Ansible
