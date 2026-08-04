# Changelog

## v0.1.0

Initial project created.

Completed:

- Raspberry Pi OS Lite installation
- Radxa Penta SATA HAT configuration
- RAID 5 created using mdadm
- ext4 filesystem created
- RAID mounted at /srv
- Git repository initialised


## v0.2.0

Docker platform created.

Completed:

- Docker Engine installed
- Docker Compose installed
- Home server directory structure created
- Environment variables moved to `.env`
- Docker data directories created
- Persistent storage locations defined


## v0.3.0

Media automation platform deployed.

Completed:

- Jellyfin installed
- Sonarr installed
- Radarr installed
- Prowlarr installed
- qBittorrent installed
- Gluetun VPN gateway configured
- qBittorrent routed through VPN
- Media folder structure created


## v0.4.0

Home media platform operational.

Completed:

- Jellyfin libraries configured
- Jellyfin users created
- Sonarr/Prowlarr/qBittorrent integration tested
- Automated TV download and organisation tested
- Home movies and family AV libraries separated


## v0.5.0

Remote access and stability improvements.

Completed:

- Cloudflare Tunnel deployed
- Jellyfin made available securely via HTTPS
- Wi-Fi disabled
- Ethernet-only networking confirmed
- Docker Compose configuration tidied
- Duplicate Wi-Fi/LAN addressing issue resolved


## v0.6.0

Roadmap and future improvements defined.

Planned:

- Raspberry Pi NAS enclosure design
- 3D printed case prototype
- Temperature monitoring
- RAID health monitoring
- Docker service monitoring
- Server dashboard
- Alert notifications
- Backup strategy
- Disaster recovery testing


## v0.7.0

Prowlarr VPN routing and integration update.

Completed:

- Prowlarr routed through the Gluetun VPN gateway
- Prowlarr web interface exposed through Gluetun on port 9696
- Prowlarr application links for Sonarr and Radarr updated to use `http://gluetun:9696`
- Sonarr and Radarr indexer connectivity re-tested successfully
- Prowlarr VPN connectivity verified with a test indexer
- Local recovery backups excluded from Git
