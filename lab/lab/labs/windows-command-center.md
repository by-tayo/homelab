# Windows Command Center

**Repo:** TODO
**Runs on:** Dell XPS 16, reached over Tailscale

## What it is

A phone-friendly dashboard and control panel for the XPS 16: installed apps,
security posture, network status, a scoped file browser, and a small set of
controls (lock, sleep, kill process, launch allow-listed apps).

## Stack

- Python + FastAPI, bound to localhost only
- `tailscale serve` for HTTPS on the tailnet
- Mobile-first web UI, installable as a PWA

## Security design

- API token for reads, separate PIN for anything state-changing
- Per-IP lockout after repeated failed logins
- App launch and file access limited to explicit allow-lists
- Every control action written to an audit log
- Deliberately no remote toggle for Defender, firewall, or BitLocker, and no generic shell

## Status

Code scaffold built and core security checks tested; first real run on the XPS 16 still to do.
