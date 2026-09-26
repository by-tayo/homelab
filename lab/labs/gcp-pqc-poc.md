# Post-Quantum TLS Proof of Concept

**Repo:** TODO
**Runs on:** Google Cloud Platform · accessed with the gcloud CLI
**Status:** In progress

## What it is

Testing TLS handshakes that use post-quantum cryptography, to see how
quantum-resistant certificates and key exchange behave in practice.

## Components

- **Certificates:** ML-DSA-65 and ML-DSA-87 (NIST FIPS 204 signature algorithms)
- **Key exchange:** hybrid X25519MLKEM768 (classical X25519 + ML-KEM-768)
- **Tooling:** OpenSSL for handshakes, Wireshark to capture and inspect them
- **Planned:** a Java / BouncyCastle JSSE benchmarking client, and handshakes from Python

## What I've done

TODO: handshakes completed so far and what the captures showed.

## What I learned

TODO
