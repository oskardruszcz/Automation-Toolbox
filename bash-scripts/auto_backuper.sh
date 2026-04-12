#!/bin/bash

# Script Name:  auto_backuper.sh
# Description:  Automates directory backups with compression and rotation.
# Usage:        ./auto_backuper.sh /source/directory /backup/destination

SOURCE_DIR=$1
DEST_DIR=$2
DATE=$(date +%Y-%m-%d_%H%M%S)
BACKUP_NAME="backup_$DATE.tar.gz"
RETENTION_DAYS=7

if [[ -z "$SOURCE_DIR" || -z "$DEST_DIR" ]]; then
    echo "Usage: $0 <source_directory> <destination_directory>"
    exit 1
fi

if [[ ! -d "$SOURCE_DIR" ]]; then
    echo "Error: Source directory $SOURCE_DIR does not exist."
    exit 1
fi

mkdir -p "$DEST_DIR"

echo "--- Starting Backup: $DATE ---"

tar -czf "$DEST_DIR/$BACKUP_NAME" "$SOURCE_DIR" 2>/dev/null

if [ $? -eq 0 ]; then
    echo "Success: Backup saved to $DEST_DIR/$BACKUP_NAME"
else
    echo "Error: Backup failed!"
    exit 1
fi

echo "Cleaning up backups older than $RETENTION_DAYS days..."
find "$DEST_DIR" -name "backup_*.tar.gz" -type f -mtime +$RETENTION_DAYS -delete

if [ $? -eq 0 ]; then
    echo "Cleanup finished."
else
    echo "Warning: Cleanup failed or no old files found."
fi

echo "--- Backup Process Completed ---"
