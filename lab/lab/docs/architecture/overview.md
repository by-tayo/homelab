# Architecture Overview

## What this lab is

A personal environment spanning three layers:

1. **Cloud (AWS)** — internet-facing services and cloud security tooling: CloudHub, a monitoring server, and an ELK Stack SOC.
2. **Home network** — a consumer router (TP-Link Archer AX6000) with a main network for trusted devices and a guest network for untrusted ones.
3. **Virtual labs** — isolated host-only networks on the Dell XPS 16, where the Active Directory and SOC labs run.

## Trust boundaries

| Boundary | Enforced by |
|---|---|
| Internet ↔ home network | AX6000 NAT and firewall |
| Main network ↔ guest network | AX6000 guest isolation |
| Home network ↔ AD lab | Host-only VM network behind virtual pfSense |
| Remote devices ↔ lab services | Tailscale (private tailnet, no public ports) |
| Internet ↔ AWS services | AWS security groups |

## Design decisions

- **Segmentation happens inside the hypervisor, not on the router.** A consumer router can't enforce firewall rules between lab zones, so the lab networks are host-only virtual networks with pfSense as their gateway.
- **Splunk is the primary SIEM** for the on-prem labs; the ELK Stack is used in AWS.
- **Tailscale instead of port forwarding** for anything reached remotely.

## Not yet in place

See the [roadmap](../../README.md#roadmap) and [procurement roadmap](../hardware/procurement-roadmap.md).
