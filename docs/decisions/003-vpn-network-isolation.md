# Decision 003 - VPN Network Isolation

Date: 2026-07-17

## Decision

VPN-dependent services will use Gluetun as their network gateway rather than managing VPN connections individually.

The initial VPN gateway is:

- Container: gluetun
- Provider: Proton VPN
- Protocol: WireGuard

## Reason

The goal is to ensure that services requiring VPN protection cannot accidentally bypass the VPN connection.

A service should not have a normal internet connection and a VPN connection available at the same time.

The preferred design is:

Service
   |
   |
Gluetun VPN gateway
   |
   |
Proton VPN
   |
   |
Internet


## Alternatives considered

### Application-level VPN configuration

Rejected because:

- Each application would need separate VPN settings.
- Different applications may behave differently.
- Easier to accidentally misconfigure.

### Running the entire server through VPN

Rejected because:

- Normal server services need direct LAN access.
- Local media streaming should not depend on VPN availability.
- Remote administration should remain simple.

## Verification

The VPN gateway has been tested by comparing public IP addresses:

Host system: 109.153.54.211

Gluetun container: 146.70.179.42


Result:

The host uses the normal home internet connection while Gluetun traffic exits through Proton VPN.

## Future use

Containers such as qBittorrent will share the Gluetun network namespace so that loss of VPN connectivity prevents internet access.

---

## Validation - qBittorrent Integration (2026-07-18)

### Implementation

qBittorrent was added to the Docker stack using:

`network_mode: service:gluetun`

This ensures qBittorrent shares Gluetun's network namespace and has no independent internet route.

### Testing performed

- Confirmed Gluetun connects successfully to Proton VPN.
- Confirmed qBittorrent Web UI is accessible through Gluetun.
- Stopped Gluetun and confirmed qBittorrent lost network/UI access.
- Recreated the Docker stack and confirmed qBittorrent recovered.
- Confirmed qBittorrent configuration persists outside the container.

### Operational note

Restarting Gluetun alone did not restore qBittorrent connectivity because the shared network namespace was not recreated.

Recovery procedure:

```bash
docker compose down
docker compose up -d

# ADR-004: qBittorrent Configuration

## Status

Accepted

## Context

qBittorrent is the BitTorrent client for the home server and operates behind the Gluetun VPN gateway. Its configuration should support future integration with Sonarr, Radarr and other Arr applications.

## Decision

- qBittorrent stores active downloads under `/downloads/incomplete`.
- Completed downloads are stored under `/downloads/completed`.
- The corresponding host directories are:
  - `/srv/media/torrents/incomplete`
  - `/srv/media/torrents/completed`
- qBittorrent categories are not created manually.
- Sonarr and Radarr will create and manage categories during their own configuration.
- Web UI authentication is enabled with a custom administrator password.
- Networking configuration remains at the default settings because all network traffic is routed through the Gluetun container.

## Consequences

- Downloads are clearly separated from completed content.
- Future Arr applications can import completed downloads without interfering with active transfers.
- Category ownership remains with the application that uses it.
- qBittorrent remains simple to maintain and replace if required.


# ADR-005: VPN Kill Switch Validation

## Status

Verified

## Test

The qBittorrent container was tested with the Gluetun VPN gateway intentionally stopped.

## Results

- Stopping Gluetun immediately made the qBittorrent Web UI unavailable.
- The qBittorrent process remained running.
- qBittorrent did not retain an independent network interface.
- Restarting Gluetun restored connectivity.
- Gluetun public IP confirmed Proton VPN exit address.

## Evidence

qBittorrent network inspection showed:

    NetworkMode: container:<gluetun-container-id>

This confirms qBittorrent shares Gluetun's network namespace and has no direct network path.

## Conclusion

PASS — qBittorrent traffic is isolated behind the Proton VPN gateway. If the VPN connection fails, qBittorrent cannot fall back to the normal home network connection.


Decision: Raspberry Pi server operates on Ethernet only.
Reason: Repeated intermittent SSH and service connectivity issues disappeared after removing Wi-Fi and running exclusively over Ethernet. The issue was reproducible across two Raspberry Pi 5 devices, suggesting a network/interface interaction rather than hardware failure.
