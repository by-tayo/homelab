# docker-exp — Docker Engine Exporter

**Repo:** https://github.com/by-tayo/docker-exp
**Runs on:** Docker

## What it is

A Prometheus exporter for Docker Engine resource usage — the numbers behind
`docker system df` and `docker stats`, as metrics.

## What it collects

- Container counts by state, and per-container CPU, memory, and running status
- Image, volume, and build-cache counts, disk usage, and reclaimable space

## Why it's separate from sys-exp

It needs read access to the Docker socket, which is root-equivalent on the
host. Keeping it in its own project means the host metrics exporter never
needs that privilege.

## Related

Plugs into [sys-exp](sys-exp.md)'s Prometheus and Grafana instead of running its own.
