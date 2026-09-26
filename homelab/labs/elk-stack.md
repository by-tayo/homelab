# Centralized Logging & Monitoring (ELK Stack)

**Repo:** https://github.com/by-tayo/elk_stack
**Runs on:** Docker (local)

## What it is

A fully containerized centralized logging pipeline for a demo application,
with infrastructure health monitoring on top.

## Pipeline

```text
app → logs/app.log → Filebeat → Kafka (app-logs) → Logstash → Elasticsearch → Kibana
                                                                   ^
                                                         Nagios (HTTP health checks)
```

## Components

- **Demo app** — writes structured INFO / WARNING / ERROR lines with rotating log files
- **Filebeat** — tails the log and publishes to Kafka with ECS metadata
- **Kafka** — transport layer between shipper and processor
- **Logstash** — parses level, message, user ID, and latency into fields; daily indices
- **Elasticsearch + Kibana** — storage, searches, visualizations, and an importable dashboard
- **Elasticsearch Watcher** — alerts on spikes in ERROR events, with optional Slack notification
- **Nagios Core** — `check_http` on Elasticsearch and Kibana
- **GitHub Actions** — CI validation of the stack
