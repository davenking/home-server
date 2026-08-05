# KingyPiNAS

A Raspberry Pi 5-based home server and NAS, built from scratch as a learning project.

The aim is to build a reliable, documented, and recoverable server while learning Linux administration, RAID, Docker, self-hosted services, networking, monitoring, and disaster recovery.

The project deliberately avoids all-in-one NAS distributions in favour of understanding and controlling each component.

## Hardware

- Raspberry Pi 5 Model B Rev 1.1
- Radxa Penta SATA HAT
- 4 × 500 GB SATA drives
- Raspberry Pi OS Lite (64-bit)
- Ethernet-only networking

## Storage

- RAID 5 managed with `mdadm`
- ext4 filesystem
- Mounted at `/srv`

```text
/srv
├── backups
├── docker-data
├── home-server
└── media
```

## Current status

The server is stable and operational.

- RAID healthy
- Docker services running
- VPN gateway healthy
- Jellyfin remotely accessible through Cloudflare Tunnel
- Dashboard privately accessible through Cloudflare Access
- Configuration stored in Git
- Local recovery backups excluded from Git

## Running services

| Service | Purpose | Network access |
| --- | --- | --- |
| Gluetun | Proton VPN WireGuard gateway | Internal and required service ports |
| qBittorrent | Download client | Routed through Gluetun |
| Prowlarr | Indexer management | Routed through Gluetun |
| Sonarr | TV-series management | LAN |
| Radarr | Movie management | LAN |
| Jellyfin | Family media server | LAN and Cloudflare Tunnel |
| Cloudflared | Secure Cloudflare Tunnel connector | Outbound-only |
| Dashboard | KingyPiNAS website/dashboard foundation | Cloudflare Access only |

## Networking

```text
Internet
    │
Cloudflare Access
    │
Cloudflare Tunnel
    │
Dashboard container
```

The dashboard is available at:

```text
https://dashboard.kingypiweb.uk
```

Access is restricted through Cloudflare Access to approved users. It supports Cloudflare-account sign-in and email one-time PIN authentication.

No router port forwarding is used for the dashboard.

## Media automation

```text
Prowlarr
   │
   ├── Sonarr
   └── Radarr
        │
        ▼
qBittorrent
        │
        ▼
Gluetun VPN
```

Prowlarr and qBittorrent share Gluetun's network namespace. Sonarr and Radarr reach Prowlarr through:

```text
http://gluetun:9696
```

## Key directories

```text
/srv/docker-data
├── cloudflare
├── gluetun
├── jellyfin
├── prowlarr
├── qbittorrent
├── radarr
└── sonarr

/srv/media
├── movies
├── tv
├── home-movies
├── family-av
└── torrents
    ├── completed
    └── incomplete
```

The dashboard source is stored in:

```text
/srv/home-server/dashboard
```

## Documentation and recovery

- Docker Compose configuration is stored in Git.
- Secrets remain in `.env` and are not committed.
- Local recovery archives are stored in `backups/` and excluded from Git.
- Additional project documentation is stored in `docs/`.

## Roadmap

- Develop the KingyPiNAS dashboard
- Collect and display CPU, drive, RAID, VPN, tunnel, container, and backup status
- Add automated alerts
- Define and test a full backup and disaster-recovery strategy
- Build the personal website
- Develop the Reservoir scraper
- Design and 3D-print the NAS enclosure

## Philosophy

KingyPiNAS is not simply a collection of running services. The goal is to understand the system, document decisions, and build something that can be maintained and recovered with confidence.
