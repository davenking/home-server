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


## Network status-Known Issue: Intermittent SSH Reachability

The Pi has demonstrated occasional periods where SSH and ping from Windows clients fail after extended idle periods.

Observations:
- Pi remains powered and running.
- Uptime continues normally.
- Wi-Fi connection remains active.
- IP address remains unchanged.
- No wlan0 disconnect events observed in NetworkManager logs.
- Issue reproduced on a second Raspberry Pi 5.

Current assessment:
Likely network/router/ARP behaviour rather than Pi hardware or operating system failure.

Further investigation postponed while server build continues.

The server is currently operating using Ethernet only.

Previous intermittent connectivity issues were observed when Wi-Fi was enabled alongside Ethernet.

Current configuration:

- Interface: eth0
- IP address: 192.168.1.217
- Connection type: Wired
- DHCP assigned

Wi-Fi has been disabled.

The server has remained stable following this change.
