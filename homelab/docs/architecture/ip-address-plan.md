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

## Allocation rules

- `.1–.49` — servers and infrastructure (static)
- `.50–.199` — DHCP clients
- `.254` — gateway

> Adjust these rules to match what's actually configured before committing.
