# Active Directory Lab

**Repo:** https://github.com/by-tayo/ad-homelab
**Runs on:** Dell XPS 16 · VMware Workstation Pro 17

## What it is

A small enterprise Windows environment built to learn AD administration, then
used for telemetry and attack/detection practice.

## Components

- **DC01** — Windows Server 2022, AD DS + DNS, domain `corp.lab`
- **CLIENT01** — Windows 11, domain-joined, local account only (clean baseline)
- **pfSense CE** — router, DHCP, firewall on `192.168.125.0/24`
- **LOGSRV** — Splunk Enterprise receiving from both hosts
- **Kali** — attack box on the lab network

## What I've done

- Bulk-provisioned 1000+ users with PowerShell
- Three observable GPOs: logon banner, wallpaper via UNC share (needed loopback processing), Control Panel restriction
- Sysmon + Splunk Universal Forwarder on DC01 and CLIENT01, confirmed end-to-end
- BloodHound CE enumeration of the domain
- Kerberoasting against a deliberately weak service account, cracked with hashcat, detected in Splunk (Event ID 4769, RC4 encryption, attacker IP)

## Based on

Lab material from Josh Madakor, extended with pfSense, Splunk, and the attack/detection phase.
