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

The project will use a single compose.yaml file.

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
