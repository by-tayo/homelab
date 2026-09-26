# Asset Inventory

Serial numbers, IMEIs, MAC addresses, and real hostnames are intentionally omitted.

| Device | Type | Specs | Role | OS |
|---|---|---|---|---|
| Dell XPS 16 9640 | Laptop | Intel Core Ultra 9 185H (16 cores / 22 threads), 32 GB RAM | Hypervisor host, dev workstation | Windows 11 Home |
| Microsoft Surface Book 3 | Laptop | TODO | Analysis, docs, packet capture, remote admin | TODO |
| TP-Link Archer AX6000 | Router | Wi-Fi 6 | Home edge router — main + guest networks | Vendor firmware |
| iPhones | Phone | TODO: models | Mobile endpoints, Tailscale clients | iOS |
| Tablet | Tablet | TODO | Mobile endpoint | TODO |
| Samsung Galaxy S5 | Phone | — | Untrusted legacy device, guest network only | Android (no longer receives security updates) |

## Cloud assets

| Asset | Provider | Notes |
|---|---|---|
| CloudHub | AWS EC2 | Self-hosted Nextcloud |
| Monitoring server | AWS | TODO |
| ELK Stack SOC | AWS | TODO |
