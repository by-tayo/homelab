# Backup and Recovery

Target: **3-2-1** — three copies of anything I'd hate to lose, on two kinds of
media, with one copy off-site.

## Current state

- VM snapshots before risky changes.
- No 3-2-1 copy exists yet for any lab VM or service data.
- TODO: where snapshots and exports are stored today.

## Plan

| Copy | What | Where | Media | Status |
|---|---|---|---|---|
| 1 — primary | Live VMs and service data | XPS 16 (security lab), Surface Book 3 (services lab) | Internal SSD | In place |
| 2 — local backup | Proxmox `vzdump` backups of services lab VMs; VM exports of the security lab | A second virtual disk on the Surface Book, then copied to the other laptop | Internal SSD (other host) | Planned |
| 3 — off-site | Weekly copy of the backups | External drive kept away from the desk, or encrypted cloud storage | External drive / cloud | Planned |

## Rules

- Back up data **before** tearing anything down, not partway through.
- Nothing depends on a service I might remove later.
- Secrets in backups are encrypted; backups never go into Git.
- A backup isn't real until a restore has worked.

## Restore tests

| Date | What was restored | From | Result |
|---|---|---|---|
| TODO | First test: one services lab VM from a Proxmox backup | Copy 2 | — |
