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
