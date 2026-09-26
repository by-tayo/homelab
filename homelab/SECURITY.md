# Security and Disclosure

## Authorized use

This repository documents a personal lab. All security testing described here
was performed only against systems I own or deployed myself inside isolated
lab networks. Nothing here should be used against systems you do not own or
have explicit written permission to test.

## What is deliberately excluded

Before anything is committed, it is scrubbed of:

- Passwords, API keys, tokens, PINs, SSH private keys, VPN keys, recovery codes
- `.env` files (only `.env.example` with placeholders is committed)
- Public IP addresses, DDNS names, and Tailscale MagicDNS names
- MAC addresses, serial numbers, IMEIs, and device identifiers
- Wi-Fi network names (SSIDs)
- Real hostnames that identify me or my devices
- Router, firewall, or hypervisor configuration exports

## Screenshots

Every screenshot is checked before commit for hostnames, usernames, IPs,
tokens, and browser tabs or notifications in the frame.

## Found something I missed?

If you spot sensitive information in this repo, please open an issue without
repeating the sensitive value, and I'll remove it and rotate anything affected.
