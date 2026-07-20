## Goals

The Docker platform aims to provide:

- Repeatable deployments
- Simple recovery
- Clear separation of configuration and data
- Secure network isolation
- Easy maintenance

# Docker Platform

## Overview

KingyPiNAS uses Docker to provide isolated, repeatable services.

Docker allows applications to be installed, updated and removed without affecting the base operating system.

## Platform

Hardware:

- Raspberry Pi 5 Model B Rev 1.1
- Radxa Penta SATA HAT
- 4 x 500GB SATA drives

Operating System:

- Raspberry Pi OS Lite 64-bit
- Debian Trixie

Docker:

- Docker Engine 26.1.5
- Docker Compose 2.26.1

## Design Decisions

### Single Compose File

The project will use a single docker-compose.yaml file.

Reasons:

- Easier maintenance
- Easier backup
- Easier rebuild after failure
- One place to understand the complete system

### Separation of Configuration and Data

Git repository:

/srv/home-server

Contains:

- Documentation
- Docker Compose files
- Scripts
- Diagrams

Persistent application data:

/srv/docker-data

Media storage:

/srv/media

This separation improves disaster recovery.

## User Permissions

Containers will normally run using:

PUID=1000  
PGID=1000

matching the dave user account.

This avoids unnecessary root-owned files and keeps permissions predictable.

## Current Architecture

Current containers:

- Gluetun
- qBittorrent

Networking:

Internet
    │
    ▼
 Proton VPN
    │
 Gluetun
    │
 qBittorrent

qBittorrent uses:

network_mode: "service:gluetun"

This ensures all torrent traffic passes through the VPN.

## Directory Layout

Repository

/srv/home-server

Persistent Docker data

/srv/docker-data

Media

/srv/media

    torrents/
        completed/
        incomplete/


## Network

The server operates on Ethernet only.

Current configuration:

- Interface: Ethernet (eth0)
- IP address: 192.168.1.217
- Address assignment: DHCP

Wi-Fi is disabled to avoid intermittent connectivity issues observed during initial deployment.

The server has remained stable following this change.

## VPN Isolation

qBittorrent runs using:

network_mode: "service:gluetun"

This means qBittorrent does not have its own network interface.

All traffic must pass through Gluetun.

If Gluetun stops:

- qBittorrent Web UI becomes unavailable.
- Torrent traffic cannot continue outside the VPN tunnel.

The VPN kill switch has been tested successfully.

## Updating Containers

Typical update procedure:

docker compose pull

docker compose up -d

docker image prune

Verify:

docker ps

## Backup Strategy

Current priorities:

- Git repository
- Docker configuration
- Application data
- Media

## Related Documentation

current-state.md

Decision Log

Docker Compose

Storage Layout
