# KingyPiNAS Current State

Date: 2026-07-20

## Platform Status

The platform has reached a stable baseline.

The Raspberry Pi server is operating reliably using Ethernet-only networking.

## Working Services

- Gluetun
  - Proton VPN WireGuard
  - Healthy
  - Provides VPN gateway for qBittorrent

- qBittorrent
  - Runs through Gluetun network namespace
  - Web UI secured
  - Configuration stored in /srv/docker-data/qbittorrent

- Prowlarr
  - Running as Docker container
  - Web UI available on port 9696
  - Configuration stored in /srv/docker-data/prowlarr
  - Provides centralised indexer management for future media services

- Sonarr
  - Running as Docker container
  - Web UI available on port 8989
  - Configuration stored in /srv/docker-data/sonarr
  - Connected to Prowlarr for indexer management
  - Connected to qBittorrent for downloads
  - manages TV series and monitors the download directory.

- Radarr
  - Running as Docker container
  - Web UI available on port 7878
  - Configuration stored in /srv/docker-data/radarr
  - Connected to Prowlarr for indexer management
  - Connected to qBittorrent for downloads
  - manages Movies and monitors the download directory.

## Validation Completed

- Confirmed Pi public IP differs from VPN IP
- Confirmed Gluetun health
- Confirmed qBittorrent cannot operate without VPN
- Confirmed configuration survives container recreation

## Next Steps

- Media services
- Storage organisation
- Monitoring
- Physical case design

## Gluetun and qBittorrent Recovery

qBittorrent uses the Gluetun container network namespace:

    network_mode: "service:gluetun"

This means qBittorrent depends on Gluetun for all network connectivity.

If Gluetun is stopped and restarted, qBittorrent may require a restart to restore Web UI access.

## Networking

Current configuration:

- Ethernet only
- Wi-Fi disabled
- IP address: 192.168.1.217
- DHCP provided by BT Smart Hub 2

Previous intermittent SSH connectivity issues occurred when both Wi-Fi and Ethernet were active.

Moving to Ethernet-only networking has resolved the issue during extended testing.

## Docker Status

Validation completed:

- Containers restart successfully after reboot
- Gluetun reports healthy
- qBittorrent reconnects correctly
- Prowlarr starts automatically
- Radarr starts automatically 
- Configuration persists after restart

## Validation Completed

- Confirmed Pi public IP differs from VPN IP
- Confirmed Gluetun health
- Confirmed qBittorrent cannot operate without VPN
- Confirmed configuration survives container recreation
- Confirmed Docker services survive reboot

## Gluetun and qBittorrent Recovery

qBittorrent uses the Gluetun container network namespace:

    network_mode: "service:gluetun"

This means qBittorrent depends on Gluetun for all network connectivity.

If Gluetun is stopped and restarted, qBittorrent may require a restart to restore Web UI access.

Recovery sequence:

```bash
docker restart gluetun

Wait until Gluetun reports healthy:

docker ps

Then restart qBittorrent:

docker restart qbittorrent

The qBittorrent configuration is persistent in:/srv/docker-data/qbittorrent

so restarting the container does not affect settings or credentials.

Git Status
Repository clean
Changes pushed to GitHub
Documentation maintained under version control

Next Steps
Deploy Sonarr
Deploy Radarr
Deploy Jellyfin
Storage organisation
Monitoring
Backup strategy
Disaster recovery testing


