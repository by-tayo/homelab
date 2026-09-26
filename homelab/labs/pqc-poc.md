# pqc-poc — Post-Quantum TLS Test Bed

**Repo:** https://github.com/by-tayo/pqc-poc
**Runs on:** Docker (local) · GCP deployment planned

## What it is

A test bed for moving TLS to post-quantum cryptography, covering both
authentication and key exchange, benchmarked against classical cryptography
across multiple language runtimes.

## Built so far

- ML-DSA-44, ML-DSA-65, and ML-DSA-87 certificates, issued by a self-hosted EJBCA certificate authority
- Bare TLS servers in Python, Java, and JavaScript, with mutual TLS (mTLS)
- Handshake benchmarks and a pytest regression suite
- Multi-tool verification: OpenSSL, native-language clients, and Wireshark captures (in progress)

## Planned

- Classical RSA/ECDSA certificate baseline
- Hybrid key exchange (ECDHE + ML-KEM)
- GCP Compute Engine VMs running the same Docker Compose stack
- Two VMs in distant regions to measure handshakes over real network latency

## What it measures

Handshake timing, certificate and key size, CPU and bandwidth cost, and how
that cost changes with network distance — plus compatibility, chain
validation, and certificate lifecycle (issuance, renewal, revocation).
