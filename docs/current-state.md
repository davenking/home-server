# KingyPiNAS Current State

Date: 2026-07-18

## Working Services

- Gluetun
  - Proton VPN WireGuard
  - Healthy
  - Provides network gateway

- qBittorrent
  - Runs through Gluetun network namespace
  - Web UI secured
  - Configuration stored in /srv/docker-data/qbittorrent

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
