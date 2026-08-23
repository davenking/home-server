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

## Phase 4 - Website and monitoring dashboard

- [x] Configure Cloudflare Tunnel
- [x] Build personal website
- [x] Create KingyPiNAS dashboard page
- [x] Add automatic status collection using systemd timer
- [x] Display Pi online status
- [x] Display system uptime and last update time
- [x] Display CPU temperature
- [x] Display individual SATA drive temperatures
- [x] Display RAID and SD card usage
- [x] Display RAM usage
- [x] Display RAID health
- [x] Display VPN connection health
- [x] Display Cloudflare Tunnel container status
- [x] Display Jellyfin, Sonarr, Radarr and Prowlarr status and uptime
- [x] Display qBittorrent and Gluetun status and uptime
- [ ] Detect stale dashboard status data
- [ ] Add status colours for warning/failure conditions
- [ ] Improve Cloudflare Tunnel connectivity monitoring
- [ ] Add stronger qBittorrent operational/VPN validation
- [ ] Display last successful backup
- [ ] Display active alerts
- [ ] Add monitoring history
- [ ] Add email alerts for temperature, RAID, VPN, container and disk-space failures
- [ ] Reservoir scraper

## Phase 5 - Physical build

- [ ] Design Raspberry Pi NAS enclosure
- [ ] Consider airflow requirements
- [ ] Design drive mounting solution
- [ ] Design cable management
- [ ] 3D print prototype
- [ ] Test temperatures under load
- [ ] Final print and assembly

## Phase 6 - Backup and recovery

- [ ] Define backup strategy
- [ ] Automate configuration backups
- [ ] Test disaster recovery procedure

## Phase 7 - Remote administration

- [ ] Design secure remote administration method
- [ ] Configure private remote SSH access
- [ ] Test remote access from outside the home network
- [ ] Test remote access after KingyPiNAS reboot
- [ ] Verify existing Docker, VPN and Cloudflare networking is unaffected
- [ ] Document remote connection and recovery procedure
