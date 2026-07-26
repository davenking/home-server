# KingyPiNAS

A Raspberry Pi 5 based home server built from scratch as a learning project.

The aim of this project is to create a reliable, documented, and easily recoverable NAS and media server while learning:

- Linux system administration
- RAID storage management
- Docker and Docker Compose
- Self-hosted services
- Media management
- Backup and recovery practices

The project deliberately avoids all-in-one NAS distributions such as CasaOS in favour of understanding and controlling each component.

---

# Hardware

## Server

- Raspberry Pi 5 Model B Rev 1.1
- Radxa Penta SATA HAT
- 4 × 500GB SATA drives
- Raspberry Pi OS Lite (64-bit)

## Storage

- RAID 5 using `mdadm`
- Filesystem: ext4
- RAID mount point:

---

/srv Storage label: NAS


---

# Project Objectives

- Build a reliable home server from scratch
- Learn Linux administration
- Learn RAID management
- Containerise services using Docker
- Keep all configuration documented
- Store configuration in Git
- Make recovery from hardware failure straightforward
- Provide family-friendly media access
- Preserve personal family archives

---

# Current Status

The server has reached a stable baseline.

## Completed

✅ Raspberry Pi operating reliably  
✅ Ethernet-only networking configured  
✅ RAID 5 storage created and mounted  
✅ Docker platform configured  
✅ Configuration stored in Git  
✅ VPN gateway configured  
✅ Download automation working  

---

# Currently Running Services

## Gluetun

Purpose:
- VPN gateway for services requiring protected traffic

Status:
- Running
- Proton VPN WireGuard configured
- Health checks enabled

---

## qBittorrent

Purpose:
- Torrent download client

Status:
- Running through Gluetun VPN

Configuration:
- /srv/docker-data/qbittorrent

Downloads:
- /srv/media/torrents


---

## Prowlarr

Purpose:
- Indexer management

Status:
- Running

Configuration:
- /srv/docker-data/prowlarr


---

## Sonarr

Purpose:
- Automated TV series management

Status:
- Running

Configuration:
- /srv/docker-data/sonarr

Media library:
- /srv/media/tv


---

## Radarr

Purpose:
- Automated movie management

Configuration:
- /srv/docker-data/radarr

Movie library:
- /srv/media/movies

---

# Planned Services

## Jellyfin

Purpose:
- Family media server

Planned libraries:

### Movies

- /srv/media/movies

### TV
- /srv/media/tv

### Home Movies

Digitised personal cine films:
- /srv/media/home-movies


### Family Archive

Family audio-visual projects created by my parents:
- /srv/media/family-av


---

# Media Storage Layout

Current and planned layout:
- /srv/media

├── movies
│
├── tv
│
├── home-movies
│
├── family-av
│
└── torrents
    ├── completed
    └── incomplete

---

# Docker Layout

Docker persistent data:
- /srv/docker-data

├── gluetun
├── qbittorrent
├── prowlarr
├── sonarr
├── radarr
├── jellyfin
└── cloudflare


---

# Documentation

Additional documentation is stored in:
- docs/


Including:

- Architecture decisions
- Docker configuration
- Current system state
- Recovery procedures

---

# Future Plans

Possible future additions:

- Jellyfin deployment
- Cloudflare tunnel
- Monitoring dashboard
- Temperature monitoring
- Automated backups
- Physical case design
- Personal website hosting
- Additional home automation projects

---

# Philosophy

The goal of KingyPiNAS is not simply to run services.

The goal is to understand how the system works, document decisions, and create a server that can be rebuilt and maintained confidently.
