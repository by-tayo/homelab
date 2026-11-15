# Threat Model

| Threat | Where | Mitigation |
|---|---|---|
| Lab attack tooling reaching real devices | Kali in AD lab | Host-only network behind pfSense |
| Attack testing breaking services I depend on | Services lab | Separate host (Surface Book 3); Kali never joins the services lab |
| Compromised legacy device | Galaxy S5 | Guest network, no real accounts |
| Exposed admin interfaces | Home, AWS, Azure, GCP (planned), services lab | Tailscale instead of public ports; security groups; Proxmox UI reachable only from the Surface Book and the tailnet |
| Compromised container reaching the hypervisor | Services lab | Apps run in Docker inside a full VM, not in LXC containers that share the Proxmox kernel |
| Nested VM traffic seen by the host | Services lab | MAC address spoofing is enabled on the Proxmox VM's adapter (needed for nested guests); accepted on an internal-only switch, revisited if the switch becomes external |
| Reverse proxy as a single point of entry | Services lab | Only apps meant to be reached are published; admin UIs stay off the proxy; Phase 2 puts the proxy in a DMZ |
| SSO outage locking me out | Services lab (Phase 2) | Authentik covers apps only; hosts keep local accounts |
| Leaked Command Center credentials | XPS 16 | Token + PIN, lockout, no remote toggle of Defender/firewall/BitLocker, no generic shell |
| Secrets committed to GitHub | This repo | `.gitignore`, pre-commit review, SECURITY.md checklist |
| Lost lab state | XPS 16 VMs, services lab data | Snapshots; 3-2-1 backups planned ([plan](../operations/backup-and-recovery.md)) |
| Honeypot compromise spreading | Azure honeypot | Own resource group, no real data or credentials, no link to home or other labs |
| Surprise cloud bills | AWS, Azure, GCP | TODO: budget alerts on each provider; shut down idle resources |
| Docker socket abuse | docker-exp | Split out from sys-exp so only one exporter needs socket access |
