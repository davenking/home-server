# KingyPiNAS

A Raspberry Pi 5 based home server built from scratch as a learning project.

The aim of this project is not simply to build a NAS, but to understand every component, document every decision, and create a system that can be rebuilt from scratch if required.

---

## Objectives

- Learn Linux system administration
- Learn RAID using `mdadm`
- Learn Docker and Docker Compose
- Build a reliable media server
- Document every step
- Keep all configuration under version control
- Make disaster recovery straightforward

---

## Hardware

| Component | Details |
|----------|---------|
| Computer | Raspberry Pi 5 |
| Storage HAT | Radxa Penta SATA HAT |
| Drives | 4 × 500 GB SATA drives |
| RAID | RAID 5 (`mdadm`) |
| Boot | Raspberry Pi OS Lite (64-bit) |

---

## Planned Services

- Docker
- Docker Compose
- Jellyfin
- Sonarr
- Radarr
- Prowlarr
- qBittorrent
- Gluetun
- Cloudflare Tunnel
- Personal Website
- SW Reservoir Data Project

---

## Project Status

| Phase | Status |
|------|:------:|
| Raspberry Pi Installation | ✅ |
| RAID Storage | ✅ |
| Git Repository | 🚧 |
| Docker | ⏳ |
| Media Stack | ⏳ |
| Website | ⏳ |
| Monitoring | ⏳ |
| Backup Strategy | ⏳ |

---

## Project Philosophy

This server is being built slowly and methodically.

Every change should be:

1. Planned
2. Documented
3. Tested
4. Committed to Git

The objective is to understand the system, not simply make it work.

---

## Future Projects

This server will eventually host several related projects.

- **KingyPiNAS** – Infrastructure
- **KingyPiWeb** – Personal website
- **KingyReservoirs** – Reservoir monitoring and charts
- **Family Archive** – Home movies and digitised cine films
