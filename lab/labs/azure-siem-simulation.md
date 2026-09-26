# SIEM Simulation with Microsoft Azure + Honeypot

**Repo:** https://github.com/by-tayo/azure-soclab
**Runs on:** Microsoft Azure
**Status:** Shut down — planned to revisit

## What it is

A SIEM simulation that watches real internet attackers hit a deliberately
exposed Windows 10 honeypot, then plots where the attacks come from on a live
attack map in Microsoft Sentinel.

## Components

- **Resource group** holding every lab resource
- **Windows 10 VM** — the honeypot, reached over RDP
- **Virtual network** and **network security group**
- **Log Analytics workspace**
- **Microsoft Sentinel** on top of the workspace

## What I did

1. Created the resource group, Windows 10 VM, virtual network, Log Analytics workspace, and Sentinel.
2. Opened the network security group to all inbound ports and turned the VM's Windows Firewall off, so the honeypot would attract as much traffic as possible.
3. Installed two Sentinel data connectors — Security Events via Legacy Agent and Windows Security Events via AMA — and created a data collection rule to forward the VM's logs to the workspace.
4. Queried the Security Events with KQL, filtered by time period.
5. Added GeoIP data to build a live attack map, watched it for 24 hours, then let it run to 48 hours to see more traffic populate.

## Based on

Lab material from Josh Madakor.

## Safety note

The honeypot is intentionally exposed to the internet. It lives in its own
resource group with nothing else in it, holds no real data or credentials,
and is not connected to the home network or any other lab.
The lab is currently shut down.

## Next time

- Rebuild the honeypot and Sentinel workspace
- TODO: what to add on the next run
