# Architecture Overview

## What this lab is

A personal environment spanning three layers:

1. **Cloud**:
   - **AWS** — CloudHub and a monitoring server
   - **Azure** — a SIEM simulation: an exposed Windows 10 honeypot feeding Microsoft Sentinel
   - **GCP** (planned) — cross-region deployment of the post-quantum TLS test bed
2. **Home network** — a consumer router (TP-Link Archer AX6000) with a main network for trusted devices and a guest network for untrusted ones.
3. **Virtual labs** — isolated host-only networks on the Dell XPS 16, where the Active Directory and SOC labs run.
4. **Containers** — Docker Compose stacks run locally: the ELK logging pipeline, the sys-exp/docker-exp monitoring stack, the pqc-poc TLS test bed, and Gitea.

## Trust boundaries

| Boundary | Enforced by |
|---|---|
| Internet ↔ home network | AX6000 NAT and firewall |
| Main network ↔ guest network | AX6000 guest isolation |
| Home network ↔ AD lab | Host-only VM network behind virtual pfSense |
| Remote devices ↔ lab services | Tailscale (private tailnet, no public ports) |
| Internet ↔ AWS services | AWS security groups |
| Internet ↔ Azure honeypot | Deliberately open network security group; isolated in its own resource group |
| Internet ↔ GCP instances (planned) | VPC firewall rules; access via gcloud CLI |

## Design decisions

- **Segmentation happens inside the hypervisor, not on the router.** A consumer router can't enforce firewall rules between lab zones, so the lab networks are host-only virtual networks with pfSense as their gateway.
- **Splunk is the primary SIEM** for the on-prem labs; the ELK Stack runs locally in Docker, and Microsoft Sentinel is used in Azure.
- **One cloud per job.** Each provider hosts the project that fits it, which also means practicing three different IAM and networking models.
- **Tailscale instead of port forwarding** for anything reached remotely.

## Not yet in place

See the [roadmap](../../README.md#roadmap) and [procurement roadmap](../hardware/procurement-roadmap.md).
