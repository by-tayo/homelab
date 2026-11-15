# 2026-11-14 — Planning the services lab

**Area:** Surface Book 3 · Hyper-V · Proxmox (services lab)

## Goal
Go through the "Lessons from homelabbing" talk a friend shared, compare it to
what I've already built, and plan the next part of the lab.

## What I did
- Compared the talk's roadmap to my lab. The XPS 16 already covers the security
  side: pfSense, an AD domain, Sysmon + Splunk, and a Kerberoasting attack
  detected in Splunk. What I don't have yet is the self-hosting side: Proxmox,
  Docker services, a reverse proxy, my own CA, and SSO.
- Checked my hardware. The Surface Book 3 has 32 GB RAM, an i7-1065G7
  (4 cores / 8 threads), and Windows 11 Pro with Hyper-V — more memory than the
  laptop in the talk's first homelab.
- Decided on the split: the XPS 16 stays the security lab; the Surface Book 3
  becomes the services lab, with Proxmox running nested inside Hyper-V.
- Wrote the first two scripts: `infrastructure/hyperv/new-labnat.ps1`
  (internal switch + NAT on `10.10.20.0/24`) and
  `infrastructure/hyperv/new-proxmox-vm.ps1`.

## What broke
Nothing yet — nothing has been run.

## How I fixed it
—

## What I learned
Services I depend on and destructive testing belong on different hosts. On a
Wi-Fi-only laptop, an internal switch with NAT is the reliable way to give
nested VMs a network.
