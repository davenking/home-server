# Decision 002 - Docker Layout

Date:
2026-07-15

## Decision

Docker configuration will live inside the Git repository.

Persistent application data will live separately under:

/srv/docker-data

Media files will live under:

/srv/media

## Reason

This separates:

- source configuration
- application state
- media content

This makes backup, recovery and troubleshooting easier.

## Recovery Benefit

If the Raspberry Pi SD card fails:

1. Reinstall Raspberry Pi OS.
2. Clone the repository.
3. Restore Docker data if required.
4. Restart services.

The RAID array containing media remains separate.

## Result

The server layout is predictable and documented.
