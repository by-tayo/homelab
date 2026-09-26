# Network Segmentation

## Current approach

The AX6000 is a consumer router. It separates a main network from a guest
network, but it can't enforce firewall rules between multiple lab zones. So:

- **Home-level separation** — trusted devices on main, untrusted on guest.
- **Lab-level separation** — AD lab VMs sit on a host-only network with virtual pfSense as their only gateway. Legacy NAT adapters were removed so pfSense is the sole path.

## Why the Galaxy S5 is on the guest network

It no longer receives security patches. It's useful for observing how an
unpatched device behaves on a network, and dangerous anywhere else.

## Planned

Physical VLANs once a managed switch is added.
