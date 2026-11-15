# How to apply these updates

This bundle has 17 files: 10 replace files you already have and 7 are new.
The folder layout matches the repo **after** step 2 (everything moved out of
the `homelab/` subfolder). Don't copy this `APPLY.md` into the repo.

Run these in PowerShell from your local clone of `by-tayo/homelab`. Each block
checks before it changes anything.

## Step 1 — Start from a clean, current copy

```powershell
git checkout main
git pull
if (git status --porcelain) { Write-Warning "You have uncommitted changes. Commit or stash them first." } else { Write-Host "[ok] Working tree clean" }
```

**Checkpoint:** `[ok] Working tree clean`.

## Step 2 — Move everything out of `homelab/` (fixes the broken README links)

The root `README.md` links to `docs/`, `journal/`, `SECURITY.md` and so on, but
those live in `homelab/`, so every link 404s on GitHub. Moving them to the root
fixes that.

```powershell
if (-not (Test-Path .\homelab)) {
    Write-Host "[skip] No homelab\ folder - already moved"
} else {
    $clashes = Get-ChildItem -Force .\homelab | Where-Object { Test-Path (Join-Path . $_.Name) }
    if ($clashes) {
        Write-Warning "These already exist at the root, so nothing was moved: $($clashes.Name -join ', ')"
    } else {
        Get-ChildItem -Force .\homelab | ForEach-Object { git mv "homelab/$($_.Name)" "$($_.Name)" }
        if (-not (Get-ChildItem -Force .\homelab)) { Remove-Item .\homelab }
        Write-Host "[ok] Moved homelab\* to the repo root"
    }
}
git status --short
```

**Checkpoint:** `[ok] Moved…`, and `git status` shows renames (`R`) only.

## Step 3 — Copy the bundle's files in

Set `$Bundle` to wherever you unzipped this bundle.

```powershell
$Bundle = "$env:USERPROFILE\Downloads\homelab-updates"   # change if needed
if (-not (Test-Path "$Bundle\README.md")) {
    Write-Warning "README.md not found in $Bundle. Fix the path first."
} else {
    Get-ChildItem -Path $Bundle -Recurse -File | Where-Object { $_.Name -ne "APPLY.md" } | ForEach-Object {
        $rel  = $_.FullName.Substring($Bundle.Length + 1)
        $dest = Join-Path (Get-Location) $rel
        New-Item -ItemType Directory -Force -Path (Split-Path $dest) | Out-Null
        Copy-Item $_.FullName $dest -Force
        Write-Host "[ok] $rel"
    }
}
git status --short
```

**Checkpoint:** 17 `[ok]` lines.

## Step 4 — Review, then commit

```powershell
git diff --stat
```

Read through the diff, especially the Surface Book row, the IP plan and the
roadmap. Then:

```powershell
git add -A
git commit -m "Move docs to repo root; add Surface Book services lab plan, runbook, and scripts"
git push
```

**Checkpoint:** on GitHub, click a few README links (architecture overview,
`journal/`, `SECURITY.md`). They should open, and the diagram should show near
the top.

## What changed

| File | Change |
|---|---|
| `README.md` | Diagram added; Surface Book 3 is now the services lab host; new software rows; services lab in Projects; roadmap reordered (Proxmox no longer waits on the mini PC) |
| `docs/architecture/overview.md` | Services lab layer, new trust boundaries, design decisions, open decisions |
| `docs/architecture/network-zones.md` | Planned services lab, LAN and DMZ zones |
| `docs/architecture/ip-address-plan.md` | Services lab subnet `10.10.20.0/24` |
| `docs/hardware/asset-inventory.md` | Surface Book 3 specs filled in; hypervisors by host |
| `docs/hardware/procurement-roadmap.md` | External drive moved to Now; USB-C Ethernet added; mini PC moved to Later |
| `docs/operations/backup-and-recovery.md` | 3-2-1 plan and a restore-test log |
| `docs/operations/monitoring.md` | Uptime Kuma, plus OPNsense/Docker logs to Splunk |
| `docs/security/threat-model.md` | Services lab threats: shared kernel, MAC spoofing, reverse proxy, SSO outage |
| `docs/security/access-control.md` | Proxmox UI, proxied apps, and lab VM access rules |
| `infrastructure/README.md` | `hyperv/` folder listed |
| `infrastructure/hyperv/new-labnat.ps1` | **New** — Step 1 script |
| `infrastructure/hyperv/new-proxmox-vm.ps1` | **New** — Step 2 script |
| `runbooks/hyperv-nat-and-proxmox.md` | **New** — Steps 1–4 with checkpoints, plus troubleshooting |
| `labs/services-lab.md` | **New** — project summary and phases |
| `journal/2026-11-14-services-lab-plan.md` | **New** — today's planning session |
| `assets/diagrams/lab-architecture.png` | **New** — architecture diagram |
