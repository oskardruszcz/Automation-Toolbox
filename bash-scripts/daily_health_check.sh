#!/bin/bash

# Script Name:  daily_health_check.sh
# Description:  Monitors system resources (CPU, RAM, Disk) and active users.

DISK_THRESHOLD=90
RAM_THRESHOLD=80

echo "       SYSTEM HEALTH REPORT - $(date)"

echo -e "\n[1/4] Checking Disk Space..."
df -h | grep '^/dev/' | while read -r line; do
    usage=$(echo "$line" | awk '{print $5}' | sed 's/%//')
    partition=$(echo "$line" | awk '{print $6}')
    if [ "$usage" -ge "$DISK_THRESHOLD" ]; then
        echo "⚠️  WARNING: Partition $partition is at ${usage}%!"
    else
        echo "✅ $partition: ${usage}% used."
    fi
done

echo -e "\n[2/4] Checking Memory (RAM)..."
free_mem=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
free_mem_int=$(printf "%.0f" "$free_mem")

if [ "$free_mem_int" -ge "$RAM_THRESHOLD" ]; then
    echo "⚠️  WARNING: High RAM usage! Current: ${free_mem_int}%"
else
    echo "✅ RAM usage: ${free_mem_int}%"
fi

echo -e "\n[3/4] Checking CPU Load Average..."
load=$(uptime | awk -F'load average:' '{ print $2 }')
echo "Current Load: $load"

echo -e "\n[4/4] Active Users Session..."
who
echo -e "\n====================================================="
echo "                  End of Report"
