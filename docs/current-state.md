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
