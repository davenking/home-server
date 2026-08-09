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


generated_at=$(date --iso-8601=seconds)
temporary_file=$(mktemp "${output_file}.XXXXXX")

printf '{
  "generated_at": "%s",
  "cpu_temperature_c": %s,
  "disk_usage_percent": %s,
  "disk_used": "%s",
  "disk_size": "%s"
}
' \
  "$generated_at" \
  "$cpu_temperature" \
  "$disk_percent" \
  "$disk_used" \
  "$disk_size" \
  > "$temporary_file"

chmod 644 "$temporary_file"
mv "$temporary_file" "$output_file"
