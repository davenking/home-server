# KingyPiNAS Current State

Date: 2026-07-29

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

- Sonarr
  - Running as a docker container
  - Web UI available on port '8989
  - Configuration stored in `/srv/docker-data/Sonarr`
  - Manages TV series and monitors the download directory.
  - Connected to Prowlarr for indexer management
  - Connected to qBittorrent for downloads 

- Radarr
  - Running as a docker container
  - Web UI available on port 7878
  - Configuration stored in `/srv/docker-data/Radarr`
  - Manages Movies and monitors the download directory.
  - Connected to Prowlarr for indexer management
  - Connected to qBittorrent for downloads

- Jellyfin
  - Running as a Docker container
  - Web UI available on port 8096
  - Configuration stored in `/srv/docker-data/jellyfin`
  - Libraries:
      - Movies
      - TV
      - Home Movies
      - Family AV
  - Remote access provided through Cloudflare Tunnel

- Cloudflared
  - Running as a Docker container
  - Authenticated Cloudflare Tunnel
  - Provides secure remote access without port forwarding

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

- Confirmed Pi public IP differs from VPN IP
Containers generally restart successfully after reboot.

Observed:
- One unexpected reboot (2026-07-29)
- qBittorrent required manual restart following that reboot
- No configuration fault identified
- Monitoring for recurrence

## Media Automation Architecture

Current workflow:

Prowlarr
    │
    ▼
Sonarr - Radarr
    │
    ▼
qBittorrent
    │
    ▼
Media library

                Prowlarr
                /      \
               /        \
         Sonarr        Radarr
              \         /
               \       /
            qBittorrent
                  |
              Gluetun VPN
                  |
             Downloaded Media
                  |
              Jellyfin
                  |
         Local & Remote Users


Notes:

- Prowlarr manages indexers and synchronises them with media applications.
- Sonarr manages TV automation.
- Sonarr sends download requests to qBittorrent.
- qBittorrent runs through Gluetun using:

      network_mode: "service:gluetun"

- Sonarr connects to qBittorrent through:

      http://gluetun:8080

because qBittorrent shares Gluetun's network namespace.

## Validation Completed

- Confirmed Gluetun health
- Confirmed qBittorrent cannot operate without VPN
- Confirmed configuration survives container recreation
- Confirmed Docker services survive reboot



## Gluetun and qBittorrent Recovery

qBittorrent uses the Gluetun container network namespace:

```
network_mode: "service:gluetun"
```

This means qBittorrent depends on Gluetun for all network connectivity.

If Gluetun is stopped and restarted, qBittorrent may require a restart to restore Web UI access.

Recovery sequence:

```
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

## Operational Notes

Unexpected reboot investigated on 2026-07-29.

Checks completed:

- RAID healthy
- CPU temperature normal
- Drive temperatures normal
- No undervoltage
- No thermal throttling
- Docker healthy
- qBittorrent required manual restart

Outcome:

No root cause identified.

Classification:

RWT (Returned Working / Tested)

Continue monitoring.

## Next Steps

- Backup strategy
- Disaster recovery testing
- Monitoring and alerting
- Personal website / dashboard
- Reservoir scraper
- Physical enclosure design
- Temperature monitoring

## Known Issues

- qBittorrent required manual restart following unexpected reboot on 2026-07-29.
- Root cause not identified.
- Monitor for recurrence before making configuration changes.
