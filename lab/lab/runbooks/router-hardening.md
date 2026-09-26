# Runbook — TP-Link Archer AX6000 Hardening

Menu names vary by firmware version. Take a screenshot of each setting before
changing it.

- [ ] Update to the latest firmware from TP-Link's official site
- [ ] Change the default admin password; store it in a password manager
- [ ] Disable remote management
- [ ] Disable WPS
- [ ] Disable UPnP (re-enable only if something truly needs it)
- [ ] Use WPA3 or WPA2/WPA3 mixed on the main network
- [ ] Enable the guest network with isolation from the main network
- [ ] Move the Galaxy S5 and other untrusted devices to the guest network
- [ ] Review the connected-device list and name each device generically
- [ ] Export a config backup and store it outside Git

## Verify

- From a guest-network device, confirm you can't reach a main-network device.
- Record results in a journal entry.
