# Asset Inventory

Serial numbers, IMEIs, MAC addresses, and real hostnames are intentionally omitted.

| Device | Type | Specs | Role | OS |
|---|---|---|---|---|
| Dell XPS 16 9640 | Laptop | Intel Core Ultra 9 185H (16 cores / 22 threads), 32 GB RAM | Hypervisor host (security lab), dev workstation | Windows 11 Home |
| Microsoft Surface Book 3 | Laptop | Intel Core i7-1065G7 (4 cores / 8 threads), 32 GB RAM, UEFI + Secure Boot | Services lab host (Hyper-V → nested Proxmox, planned); analysis, docs, remote admin | Windows 11 Pro |
| TP-Link Archer AX6000 | Router | Wi-Fi 6 | Home edge router — main + guest networks | Vendor firmware |
| iPhones | Phone | TODO: models | Mobile endpoints, Tailscale clients | iOS |
| Tablet | Tablet | TODO | Mobile endpoint | TODO |
| Samsung Galaxy S5 | Phone | — | Untrusted legacy device, guest network only | Android (no longer receives security updates) |

## Hypervisors by host

| Host | Hypervisor | What runs there |
|---|---|---|
| Dell XPS 16 | VMware Workstation Pro 17 | AD lab: pfSense, DC01, CLIENT01, LOGSRV, Kali |
| Dell XPS 16 | Oracle VirtualBox | SOC lab: Windows 11 Enterprise, Ubuntu |
| Surface Book 3 | Hyper-V | Proxmox VE as a nested VM (planned) |

## Planned hardware

| Device | Type | Specs | Planned role |
|---|---|---|---|
| Lenovo ThinkPad | Laptop | 64 GB RAM, 1 TB storage | Heavy-lab workstation for running many VMs at once |
| Mini PC | Small form factor PC | TODO | Bare-metal Proxmox host, replacing the nested Proxmox on the Surface Book |
| Raspberry Pi kit | Single-board computer | TODO | Pi-hole DNS/DHCP, always-on Linux node |

See [procurement roadmap](procurement-roadmap.md).

## Cloud assets

| Asset | Provider | Notes |
|---|---|---|
| CloudHub | AWS EC2 | Self-hosted Nextcloud |
| Monitoring server | AWS | TODO |
| SIEM simulation | Azure | Windows 10 honeypot VM, Log Analytics workspace, Microsoft Sentinel |
| pqc-poc VMs (planned) | GCP | Compute Engine VMs in two regions for cross-region TLS benchmarking |
