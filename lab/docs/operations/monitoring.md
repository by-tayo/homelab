# Monitoring

| What | Tool | Where |
|---|---|---|
| AD lab endpoints (DC01, CLIENT01) | Sysmon + Splunk Universal Forwarder → Splunk | LOGSRV |
| SOC lab | Splunk | VirtualBox lab |
| Cloud | Monitoring server, ELK Stack | AWS |
| Azure honeypot | Microsoft Sentinel + Log Analytics (KQL, GeoIP attack map) | Azure |
| TLS handshakes | Wireshark | GCP PQC POC |
| XPS 16 status | Windows Command Center | Tailscale |

## Lessons

- LOGSRV's root volume filled up and silently stopped Splunk indexing. Fixed by extending the LVM volume. Disk space is now something I check first when data stops arriving.
