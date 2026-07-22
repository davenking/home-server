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
  - Runs through the Gluetun network namespace
  - Web UI secured
  - Configuration stored in `/srv/docker-data/qbittorrent`

- Prowlarr
  - Running as a Docker container
  - Web UI available on port `9696`
  - Configuration stored in `/srv/docker-data/prowlarr`
  - Provides centralised indexer management for future media services

-Sonarr
  -Running as a docker container
  -Web UI available on port '8989
  -Configuration stored in `/srv/docker-data/Sonarr`
  -Manages TV series and monitors the download directory.

## Networking

Current configuration:

- Ethernet only
- Wi-Fi disabled
- IP address: `192.168.1.217`
- DHCP provided by BT Smart Hub 2

Previous intermittent SSH connectivity issues occurred when both Wi-Fi and Ethernet were active.

Moving to Ethernet-only networking has resolved the issue during extended testing.

## Docker Status

Validation completed:

- Containers restart successfully after reboot
- Gluetun reports healthy
- qBittorrent reconnects correctly
- Prowlarr starts automatically
- Configuration persists after restart

## Validation Completed

- Confirmed Pi public IP differs from VPN IP
- Confirmed Gluetun health
- Confirmed qBittorrent cannot operate without VPN
- Confirmed configuration survives container recreation
- Confirmed Docker services survive reboot

## Gluetun and qBittorrent Recovery

qBittorrent uses the Gluetun container network namespace:

```text
network_mode: "service:gluetun"
```

This means qBittorrent depends on Gluetun for all network connectivity.

If Gluetun is stopped and restarted, qBittorrent may require a restart to restore Web UI access.

Recovery sequence:

```bash
docker restart gluetun

docker ps

docker restart qbittorrent
```

The qBittorrent configuration is stored in:

`/srv/docker-data/qbittorrent`

so restarting the container does not affect settings or credentials.

## Git Status

- Repository clean
- Changes pushed to GitHub
- Documentation maintained under version control


## Next Steps

- Deploy Sonarr
- Deploy Radarr
- Deploy Jellyfin
- Storage organisation
- Monitoring
- Backup strategy
- Disaster recovery testing
