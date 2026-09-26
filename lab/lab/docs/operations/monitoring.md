# Monitoring

| What | Tool | Where |
|---|---|---|
| AD lab endpoints (DC01, CLIENT01) | Sysmon + Splunk Universal Forwarder → Splunk | LOGSRV |
| SOC lab | Splunk | VirtualBox lab |
| Cloud | Monitoring server, ELK Stack | AWS |
| XPS 16 status | Windows Command Center | Tailscale |

## Lessons

- LOGSRV's root volume filled up and silently stopped Splunk indexing. Fixed by extending the LVM volume. Disk space is now something I check first when data stops arriving.
