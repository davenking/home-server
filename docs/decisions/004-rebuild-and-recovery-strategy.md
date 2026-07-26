# Decision 004 - Rebuild and Recovery Strategy

Date: 2026-07-26

## Decision

The server will be designed so that a failed SD card can be replaced and the system rebuilt within a weekend.

## Principles

- The operating system is replaceable.
- Configuration should be documented and version controlled.
- Data should live separately from the operating system.
- No critical setup should exist only in memory.

## Implementation

Configuration:

/srv/home-server

contains:

- Docker Compose files
- Documentation
- Scripts
- Decision records
- Git history

Persistent application data:

/srv/docker-data

contains:

- Container configuration
- Application state

Media:

/srv/media


contains:

- Movies
- TV
- Home movies
- Family AV's
- Torrents

## Reason

The server should be understandable and recoverable without relying on the original setup session.

Future maintenance should answer:

- Where does this file live?
- Why was it configured this way?
- How do I rebuild it?
