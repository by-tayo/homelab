# Procurement Roadmap

Things I don't own yet, and why I'd add them.

Proxmox no longer waits on new hardware: it runs nested inside Hyper-V on the
Surface Book 3 for now (see the [services lab](../../labs/services-lab.md)).
The mini PC moves it to bare metal later.

| Item | Why | Priority |
|---|---|---|
| External backup drive | Second media type for 3-2-1 backups of VM exports and service data | Now |
| USB-C Ethernet adapter (Surface Book 3) | Wired link for the services lab; Hyper-V bridging over Wi-Fi is unreliable for nested guests | Next |
| Raspberry Pi kit (TODO: model) | Pi-hole DNS/DHCP, always-on low-power Linux node | Next |
| Lenovo ThinkPad — 64 GB RAM, 1 TB (TODO: model) | Heavy-lab workstation — enough memory to run the AD, SOC, and attack VMs at the same time | Next |
| TrueNAS storage | Network storage, backing store for CloudHub | Next |
| Mini PC (TODO: model) | Bare-metal Proxmox host, so services don't depend on a laptop | Later |
| Managed switch | Real VLANs instead of only virtual segmentation | Later |
