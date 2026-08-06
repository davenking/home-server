#!/usr/bin/env bash

set -euo pipefail

temperature_file="/sys/class/thermal/thermal_zone0/temp"
output_file="/srv/home-server/dashboard/status.json"

temperature_millidegrees=$(<"$temperature_file")
cpu_temperature=$(awk -v value="$temperature_millidegrees" \
  'BEGIN { printf "%.1f", value / 1000 }')

generated_at=$(date --iso-8601=seconds)
temporary_file=$(mktemp "${output_file}.XXXXXX")

printf '{\n  "generated_at": "%s",\n  "cpu_temperature_c": %s\n}\n' \
  "$generated_at" "$cpu_temperature" > "$temporary_file"

chmod 644 "$temporary_file"
mv "$temporary_file" "$output_file"
