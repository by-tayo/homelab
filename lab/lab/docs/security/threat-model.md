# Threat Model

| Threat | Where | Mitigation |
|---|---|---|
| Lab attack tooling reaching real devices | Kali in AD lab | Host-only network behind pfSense |
| Compromised legacy device | Galaxy S5 | Guest network, no real accounts |
| Exposed admin interfaces | Home, AWS | Tailscale instead of public ports; security groups |
| Leaked Command Center credentials | XPS 16 | Token + PIN, lockout, no remote toggle of Defender/firewall/BitLocker, no generic shell |
| Secrets committed to GitHub | This repo | `.gitignore`, pre-commit review, SECURITY.md checklist |
| Lost lab state | XPS 16 VMs | Snapshots; backups planned |
