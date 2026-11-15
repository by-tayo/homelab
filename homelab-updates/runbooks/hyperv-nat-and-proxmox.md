# Runbook: Services lab on Hyper-V (NAT switch + nested Proxmox)

**Host:** Microsoft Surface Book 3 · Windows 11 Pro · Hyper-V
**Result:** Proxmox VE running as a nested VM on `10.10.20.0/24`, ready for a Debian Docker VM
**Related:** [services lab](../labs/services-lab.md) · [IP plan](../docs/architecture/ip-address-plan.md)

Each step ends with a checkpoint. Don't start the next step until the
checkpoint passes.

## Before you start

- [ ] Hyper-V is enabled (Windows Features → Hyper-V).
- [ ] The Proxmox VE ISO is in your Downloads folder (`proxmox-ve_*.iso`) — from <https://www.proxmox.com/en/downloads>.
- [ ] At least ~150 GB free on the drive Hyper-V uses for virtual disks.
- [ ] The Surface Book is plugged in, with sleep turned off while the lab runs.

## Step 1 — Create the lab network

Open PowerShell **as Administrator** in this repo's folder and run:

```powershell
.\infrastructure\hyperv\new-labnat.ps1
```

It creates an internal switch `LabNAT`, gives the host `10.10.20.1`, and adds a
Windows NAT for `10.10.20.0/24`. It skips anything that already exists.

**Checkpoint:** three `[ok]` or `[skip]` lines, then a summary showing
`LabNAT` (Internal), `10.10.20.1/24`, and a NAT for `10.10.20.0/24`.
A yellow warning means it stopped on purpose — read it before changing anything.

## Step 2 — Create the Proxmox VM

```powershell
.\infrastructure\hyperv\new-proxmox-vm.ps1
```

It finds the newest ISO in Downloads, checks disk space, then creates a
Generation 2 VM with 16 GB fixed memory, 4 vCPUs, a 128 GB disk, nested
virtualization, and MAC address spoofing.

**Checkpoint:** the summary shows `ExposeVirtualizationExtensions True`,
`DynamicMemoryEnabled False`, `MacAddressSpoofing On`, switch `LabNAT`.

## Step 3 — Install Proxmox VE

1. Start the VM and connect to its console in Hyper-V Manager.
2. Choose the graphical installer and accept the defaults for the disk.
3. Network settings:

   | Field | Value |
   |---|---|
   | Hostname (FQDN) | `pve.lab.home.arpa` |
   | IP address (CIDR) | `10.10.20.10/24` |
   | Gateway | `10.10.20.1` |
   | DNS server | Your home router's IP or a public resolver (Windows NAT doesn't provide DNS) |

4. Finish the install and let it reboot. Detach the ISO afterward
   (VM Settings → SCSI Controller → DVD Drive → None).

**Checkpoint:** from the Surface Book, open `https://10.10.20.10:8006` and log
in as `root` with the password set during install. The certificate warning is
expected until the internal CA exists.

## Step 4 — Check that nesting works

In the Proxmox web UI, open the node's **Shell** and run:

```bash
grep -cE 'vmx|svm' /proc/cpuinfo
```

**Checkpoint:** a number greater than `0` means Proxmox can run VMs. A `0`
means nested virtualization isn't reaching the VM — shut it down and re-check
Step 2's settings.

## Steps 5–8 — To be written as they're built

5. Create a Debian VM in Proxmox (`10.10.20.20`) and install Docker.
6. Deploy Nginx Proxy Manager, Uptime Kuma, and one daily-use service under `lab.home.arpa` names.
7. Join the Debian VM to the existing tailnet; nothing gets a public port.
8. Set up Proxmox backups and run the first restore test ([backup plan](../docs/operations/backup-and-recovery.md)).

## Troubleshooting

| Symptom | Likely cause | Fix |
|---|---|---|
| Script stops: "Another NAT already exists" | Docker Desktop, WSL, or an older lab created a NetNat | Run `Get-NetNat` to see it; remove it only if you know nothing needs it |
| Proxmox has no internet | DNS not set, or NAT missing | Re-run Step 1; check the DNS server in `/etc/resolv.conf` |
| VMs inside Proxmox have no network | MAC address spoofing off | VM off → `Get-VMNetworkAdapter -VMName proxmox \| Set-VMNetworkAdapter -MacAddressSpoofing On` |
| "KVM virtualisation configured, but not available" | Nested virtualization off | VM off → `Set-VMProcessor -VMName proxmox -ExposeVirtualizationExtensions $true` |
