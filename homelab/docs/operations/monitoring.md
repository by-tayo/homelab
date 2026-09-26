# Monitoring

| What | Tool | Where |
|---|---|---|
| AD lab endpoints (DC01, CLIENT01) | Sysmon + Splunk Universal Forwarder → Splunk | LOGSRV |
| SOC lab | Splunk | VirtualBox lab |
| Cloud | Monitoring server | AWS |
| Hosts (multi-device over Tailscale) | [sys-exp](https://github.com/by-tayo/sys-exp) → Prometheus, Grafana, Alertmanager, anomaly detection | Docker |
| Docker Engine | [docker-exp](https://github.com/by-tayo/docker-exp) → same Prometheus/Grafana | Docker |
| Application logs | [elk_stack](https://github.com/by-tayo/elk_stack) — Filebeat → Kafka → Logstash → Elasticsearch → Kibana; Watcher alerts; Nagios health checks | Docker |
| Azure honeypot | Microsoft Sentinel + Log Analytics (KQL, GeoIP attack map) | Azure |
| TLS handshakes | Wireshark / tshark | [pqc-poc](https://github.com/by-tayo/pqc-poc) |
| XPS 16 status | Windows Command Center | Tailscale |

## Lessons

- LOGSRV's root volume filled up and silently stopped Splunk indexing. Fixed by extending the LVM volume. Disk space is now something I check first when data stops arriving.
