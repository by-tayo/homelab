# sys-exp — System Information Exporter

**Repo:** https://github.com/by-tayo/sys-exp
**Runs on:** Docker · one agent per device, aggregated over Tailscale

## What it is

A host-level metrics exporter built with FastAPI and the Prometheus Python
client, with Grafana dashboards, Alertmanager, and built-in anomaly detection.

## What it collects

- CPU, memory, disk, network, and per-process metrics (psutil)
- NVIDIA GPU load, memory, and temperature (GPUtil), when available
- `system_anomaly_detected` — an online `IsolationForest` model flags unusual CPU/memory/network samples

## Alerting

Threshold alerts for CPU, memory, and disk, an exporter-down alert, and an
anomaly alert wired to the model's output.

## Multi-device

Each device runs its own agent bound to its Tailscale address; Prometheus
scrapes them all under one job, without exposing LAN IPs.

## Related

[docker-exp](docker-exp.md) plugs into the same Prometheus/Grafana stack.
