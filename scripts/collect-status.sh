#!/usr/bin/env bash

set -euo pipefail

temperature_file="/sys/class/thermal/thermal_zone0/temp"
output_file="/srv/home-server/dashboard/status.json"

temperature_millidegrees=$(<"$temperature_file")
cpu_temperature=$(awk -v value="$temperature_millidegrees" \
  'BEGIN { printf "%.1f", value / 1000 }')
disk_size=$(df -h /srv | awk 'NR==2 {print $2}')
disk_used=$(df -h /srv | awk 'NR==2 {print $3}')
disk_percent=$(df -h /srv | awk 'NR==2 {gsub(/%/, "", $5); print $5}')

sd_size=$(df -h / | awk 'NR==2 {print $2}')
sd_used=$(df -h / | awk 'NR==2 {print $3}')
sd_percent=$(df -h / | awk 'NR==2 {gsub(/%/, "", $5); print $5}')

ram_total=$(free -m | awk '/^Mem:/ {print $2}')
ram_available=$(free -m | awk '/^Mem:/ {print $7}')
ram_used=$((ram_total - ram_available))
ram_used_percent=$(awk -v used="$ram_used" -v total="$ram_total" \
  'BEGIN { printf "%.0f", (used / total) * 100 }')


##System health##
# Collect RAID status
raid_state=$(sudo /usr/sbin/mdadm --detail /dev/md0 \
  | grep "State :" \
  | awk -F ': ' '{gsub(/^ +| +$/, "", $2); print $2}')

raid_failed_devices=$(sudo /usr/sbin/mdadm --detail /dev/md0 \
  | grep "Failed Devices" \
  | awk -F ': ' '{print $2}')

#VPN Health
vpn_health=$(docker inspect -f '{{.State.Health.Status}}' gluetun)


# Collect system uptime
system_uptime=$(uptime -p | cut -c 4-)

# Collect SMART temperatures for each RAID drive

for drive in sda sdb sdc sdd
do
    temperature=$(sudo smartctl -A /dev/$drive \
        | grep Temperature_Celsius \
        | awk '{print $10}')

    case "$drive" in
        sda)
            sda_temperature="$temperature"
            ;;
        sdb)
            sdb_temperature="$temperature"
            ;;
        sdc)
            sdc_temperature="$temperature"
            ;;
        sdd)
            sdd_temperature="$temperature"
            ;;
    esac
done


#docker status
current_epoch=$(date +%s)
#Jellyfin
jellyfin_started=$(docker inspect -f '{{.State.StartedAt}}' jellyfin)
jellyfin_started_epoch=$(date -d "$jellyfin_started" +%s)
jellyfin_age_seconds=$((current_epoch - jellyfin_started_epoch))
jellyfin_uptime=$(printf "%s wks, %s days, %s hrs" \
  "$((jellyfin_age_seconds / 604800))" \
  "$((jellyfin_age_seconds % 604800 / 86400))" \
  "$((jellyfin_age_seconds % 86400 / 3600))")
jellyfin_state=$(docker inspect -f '{{.State.Status}}' jellyfin)

#Sonarr
sonarr_started=$(docker inspect -f '{{.State.StartedAt}}' sonarr)
sonarr_started_epoch=$(date -d "$sonarr_started" +%s)
sonarr_age_seconds=$((current_epoch - sonarr_started_epoch))
sonarr_uptime=$(printf "%s wks, %s days, %s hrs" \
  "$((sonarr_age_seconds / 604800))" \
  "$((sonarr_age_seconds % 604800 / 86400))" \
  "$((sonarr_age_seconds % 86400 / 3600))")
sonarr_state=$(docker inspect -f '{{.State.Status}}' sonarr)

#Radarr
radarr_started=$(docker inspect -f '{{.State.StartedAt}}' radarr)
radarr_started_epoch=$(date -d "$radarr_started" +%s)
radarr_age_seconds=$((current_epoch - radarr_started_epoch))
radarr_uptime=$(printf "%s wks, %s days, %s hrs" \
  "$((radarr_age_seconds / 604800))" \
  "$((radarr_age_seconds % 604800 / 86400))" \
  "$((radarr_age_seconds % 86400 / 3600))")
radarr_state=$(docker inspect -f '{{.State.Status}}' radarr)

#Prowlarr
prowlarr_started=$(docker inspect -f '{{.State.StartedAt}}' prowlarr)
prowlarr_started_epoch=$(date -d "$prowlarr_started" +%s)
prowlarr_age_seconds=$((current_epoch - prowlarr_started_epoch))
prowlarr_uptime=$(printf "%s wks, %s days, %s hrs" \
  "$((prowlarr_age_seconds / 604800))" \
  "$((prowlarr_age_seconds % 604800 / 86400))" \
  "$((prowlarr_age_seconds % 86400 / 3600))")
prowlarr_state=$(docker inspect -f '{{.State.Status}}' prowlarr)

#qBittorrent
qbittorrent_state=$(docker inspect -f '{{.State.Status}}' qbittorrent)
qbittorrent_started=$(docker inspect -f '{{.State.StartedAt}}' qbittorrent)
qbittorrent_started_epoch=$(date -d "$qbittorrent_started" +%s)
qbittorrent_age_seconds=$((current_epoch - qbittorrent_started_epoch))
qbittorrent_uptime=$(printf "%s wks, %s days, %s hrs" \
  "$((qbittorrent_age_seconds / 604800))" \
  "$((qbittorrent_age_seconds % 604800 / 86400))" \
  "$((qbittorrent_age_seconds % 86400 / 3600))")

#Glutun
gluetun_started=$(docker inspect -f '{{.State.StartedAt}}' gluetun)
gluetun_started_epoch=$(date -d "$gluetun_started" +%s)
gluetun_age_seconds=$((current_epoch - gluetun_started_epoch))
gluetun_uptime=$(printf "%s wks, %s days, %s hrs" \
  "$((gluetun_age_seconds / 604800))" \
  "$((gluetun_age_seconds % 604800 / 86400))" \
  "$((gluetun_age_seconds % 86400 / 3600))")
gluetun_state=$(docker inspect -f '{{.State.Status}}' gluetun)

generated_at=$(date --iso-8601=seconds)
temporary_file=$(mktemp "${output_file}.XXXXXX")

printf '{
  "generated_at": "%s",
  "cpu_temperature_c": %s,
  "disk_usage_percent": %s,
  "disk_used": "%s",
  "disk_size": "%s",
  "sd_usage_percent": %s,
  "sd_used": "%s",
  "sd_size": "%s",
  "ram_used_percent": %s,
  "ram_used_mib": %s,
  "ram_total_mib": %s,
  "system_uptime": "%s",
  "sda_temperature_c": %s,
  "sdb_temperature_c": %s,
  "sdc_temperature_c": %s,
  "sdd_temperature_c": %s,
  "raid_state": "%s",
  "raid_failed_devices": %s,
  "jellyfin_uptime": "%s",
  "jellyfin_state": "%s",
  "sonarr_uptime": "%s",
  "sonarr_state": "%s",
  "radarr_uptime": "%s",
  "radarr_state": "%s",
  "prowlarr_uptime": "%s",
  "prowlarr_state": "%s",
  "qbittorrent_uptime": "%s",
  "qbittorrent_state": "%s",
  "gluetun_uptime": "%s",
  "gluetun_state": "%s",
  "vpn_health": "%s"


}
' \
  "$generated_at" \
  "$cpu_temperature" \
  "$disk_percent" \
  "$disk_used" \
  "$disk_size" \
  "$sd_percent" \
  "$sd_used" \
  "$sd_size" \
  "$ram_used_percent" \
  "$ram_used" \
  "$ram_total" \
  "$system_uptime" \
  "$sda_temperature" \
  "$sdb_temperature" \
  "$sdc_temperature" \
  "$sdd_temperature" \
  "$raid_state" \
  "$raid_failed_devices" \
  "$jellyfin_uptime" \
  "$jellyfin_state" \
  "$sonarr_uptime" \
  "$sonarr_state" \
  "$radarr_uptime" \
  "$radarr_state" \
  "$prowlarr_uptime" \
  "$prowlarr_state" \
  "$qbittorrent_uptime" \
  "$qbittorrent_state" \
  "$gluetun_uptime" \
  "$gluetun_state" \
  "$vpn_health" \
  > "$temporary_file"

chmod 644 "$temporary_file"
mv "$temporary_file" "$output_file"
