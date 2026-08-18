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

# Collect RAID status
raid_state=$(sudo /usr/sbin/mdadm --detail /dev/md0 \
  | grep "State :" \
  | awk -F ': ' '{gsub(/^ +| +$/, "", $2); print $2}')

raid_failed_devices=$(sudo /usr/sbin/mdadm --detail /dev/md0 \
  | grep "Failed Devices" \
  | awk -F ': ' '{print $2}')


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
  "raid_failed_devices": %s

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
  > "$temporary_file"

chmod 644 "$temporary_file"
mv "$temporary_file" "$output_file"
