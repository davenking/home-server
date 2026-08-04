# TODO

## Phase 1
- [x] Install Raspberry Pi OS
- [x] Configure SSH
- [x] Configure Ethernet networking
- [x] Configure RAID 5
- [x] Mount RAID

## Phase 2
- [x] Install Docker
- [x] Install Docker Compose
- [x] Create Docker directory layout
- [x] Configure environment variables

## Phase 3
- [x] Install Jellyfin
- [x] Install Sonarr
- [x] Install Radarr
- [x] Install Prowlarr
- [x] Install qBittorrent
- [x] Install Gluetun


## Phase 4
- [ ] Personal website
- [ ] Reservoir scraper
- [ ] Cloudflare Tunnel

## Phase 5 - Physical build
- [ ] Design Raspberry Pi NAS enclosure
- [ ] Consider airflow requirements
- [ ] Design drive mounting solution
- [ ] Design cable management
- [ ] 3D print prototype
- [ ] Test temperatures under load
- [ ] Final print and assembly

## Phase 6 - Reliability
- [ ] Backup strategy
- [ ] Disaster recovery testing
- [ ] Monitoring and alerting

## Future improvements

- [ ] Evaluate moving Prowlarr behind Gluetun VPN
      - Reason: consistent VPN routing for indexer traffic
      - Risk: Docker networking changes
      - Test required: Sonarr/Radarr ↔ Prowlarr communication

## Monitoring and alerting

- [ ] Monitor Raspberry Pi CPU temperature
- [ ] Monitor SATA drive temperatures
- [ ] Monitor RAID health
- [ ] Monitor Docker container status
- [ ] Create server dashboard
- [ ] Add temperature/failure alerts
