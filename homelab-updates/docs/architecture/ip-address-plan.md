# IP Address Plan

Only lab addresses are published. Home network ranges, public IPs, and
Tailscale addresses are intentionally left out.

## AD lab — `corp.lab`

| Item | Value |
|---|---|
| Subnet | `192.168.125.0/24` |
| Gateway / DHCP | pfSense — `192.168.125.254` |
| DNS | DC01 |
| LOGSRV (Splunk receiver) | `192.168.125.30`, port 9997 |
| DC01, CLIENT01, Kali | TODO: static or DHCP? |

## SOC lab

| Item | Value |
|---|---|
| Network type | TODO: VirtualBox NAT / host-only / internal |
| Subnet | TODO |

## Services lab — Surface Book 3 (planned)

| Item | Value | Status |
|---|---|---|
| Hyper-V switch | `LabNAT` (internal switch + Windows NAT) | Planned |
| Subnet | `10.10.20.0/24` | Planned |
| Gateway | `10.10.20.1` (Surface Book host side of `LabNAT`) | Planned |
| DHCP | None — Windows NAT doesn't serve DHCP; static addresses until OPNsense is added | Planned |
| Proxmox VE | `10.10.20.10` — web UI on port 8006 | Proposed |
| Debian Docker VM | `10.10.20.20` | Proposed |
| Internal DNS names | `*.lab.home.arpa` | Proposed |

Phase 2 (OPNsense LAN + DMZ) subnets: TODO, decided when the firewall rules are drawn.

## Allocation rules

- `.1–.49` — servers and infrastructure (static)
- `.50–.199` — DHCP clients
- `.254` — gateway

> Exception: in the services lab, `.1` is the gateway because Windows NAT puts
> the host's address there. Adjust these rules to match what's actually
> configured before committing.
