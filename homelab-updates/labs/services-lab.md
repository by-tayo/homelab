# Services Lab

**Status:** Planned — Step 1 script written, not yet run
**Runs on:** Microsoft Surface Book 3 · Hyper-V → Proxmox VE (nested)
**Runbook:** [hyperv-nat-and-proxmox](../runbooks/hyperv-nat-and-proxmox.md)

## What it is

The self-hosting half of the lab. The XPS 16 is where I attack and break
things; the Surface Book 3 runs services I actually use, so testing never takes
them down. It follows the roadmap from the "Lessons from homelabbing" talk by
William Anderson and Nathan Bledsoe (UTSA).

## Why the Surface Book 3

It has 32 GB RAM and Windows 11 Pro with Hyper-V, so it can host Proxmox as a
nested VM with no new hardware. Its limit is the CPU (4 cores / 8 threads), so
it gets the lighter, always-on services.

## Phases

| Phase | What it adds | Status |
|---|---|---|
| 1. Start simple | Hyper-V NAT switch, nested Proxmox, Debian VM + Docker, Nginx Proxy Manager, Uptime Kuma, one daily-use service (Vaultwarden or Immich), `lab.home.arpa` names, join the existing tailnet, 3-2-1 backups | Planned |
| 2. Two networks + security | OPNsense with LAN + DMZ segments (firewall rules drawn first), an internal CA for HTTPS, Authentik SSO for apps while hosts keep local logins | Planned |
| 3. Attack and log it | Pentest the services lab from Kali on the XPS, publish the report, send OPNsense and Docker logs to Splunk, turn findings into detections | Planned |
| 4. Advanced | Terraform-built cyber range on Proxmox, container escape practice, k3s | Planned |

## Design choices

- **Internal switch + NAT**, not an external switch: the Surface Book is Wi-Fi only, and bridging over Wi-Fi is unreliable for nested guests.
- **Apps in Docker inside a VM**, not LXC: LXC containers share the Proxmox host kernel.
- **Nothing on a public port** — remote access through the existing tailnet only.
- **SSO for apps, local logins for hosts**, so an SSO outage can't lock me out.

## Open decisions

- Internal CA: EJBCA (already running for pqc-poc) or step-ca.
- First daily-use service: Vaultwarden or Immich.

## Log

| Date | What happened |
|---|---|
| 2026-11-14 | Planned the build; wrote the Step 1 (NAT switch) and Step 2 (Proxmox VM) scripts. See [journal](../journal/2026-11-14-services-lab-plan.md). |
