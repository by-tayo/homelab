# Access Control

| Access path | Control |
|---|---|
| Remote access to home devices | Tailscale only — no port forwarding |
| Windows Command Center | API token for read access + separate PIN for any state-changing action; per-IP lockout after failed attempts; audit log |
| AWS instances | Security groups, SSH key auth |
| Azure honeypot | RDP only for setup; intentionally open NSG — treated as compromised |
| GCP (planned) | gcloud CLI with IAM; VPC firewall rules |
| sys-exp agents | Bound to Tailscale addresses, not LAN IPs |
| docker-exp | Needs the Docker socket (root-equivalent) — kept separate from sys-exp on purpose |
| Lab domain accounts | Test accounts only — never reused elsewhere |
| Proxmox VE web UI (planned) | Local Proxmox account; reached from the Surface Book host or the tailnet only, never through the reverse proxy |
| Services lab apps (planned) | Behind Nginx Proxy Manager over HTTPS; Phase 2 moves app logins to Authentik SSO |
| Services lab VMs (planned) | SSH keys, local accounts — not tied to SSO, so an SSO outage can't lock me out |
| Secrets | Password manager or local `.env` files, never Git |

## Principles

- Separate secrets for read and control.
- Allow-lists over block-lists (launchable apps, file roots).
- Log every privileged action.
- SSO for apps, local logins for hosts.
