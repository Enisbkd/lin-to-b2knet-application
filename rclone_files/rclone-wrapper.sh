#!/bin/bash

# Set configuration
PREFIX="b2knetIn"
HEADER="Code;CardCode;LastName;FirstName;CategoryCode;CategoryDescription;FunctionCode;FunctionDescription;ShiftCode;ShiftDescription;Gender;LANGUAGE;ChangeSize;ContractStart;ContractEnd;DisableDate;Mag;PrimaryMag;"

echo "Starting rclone mount for real-time sync..."

# Create mount point
MOUNT_POINT="/tmp/minio-mount"
mkdir -p "${MOUNT_POINT}"
mkdir -p "/data/minio-backup"

# Start rclone mount in background
rclone mount \
  minio:kafka-sink/topics/ \
  "${MOUNT_POINT}" \
  --config /config/rclone.conf \
  --log-file /logs/rclone.log \
  --log-level INFO \
  --vfs-cache-mode full \
  --vfs-cache-max-age 10s \
  --vfs-cache-poll-interval 5s \
  --allow-other \
  --daemon

# Wait for mount to be ready
sleep 3

echo "Mount established. Starting file watcher..."

# Watch for new files and process them
while true; do
  find "${MOUNT_POINT}" -type f 2>/dev/null | while read -r file; do
    TIMESTAMP=$(date +%Y%m%d%H%M%S)
    filename=$(basename "$file")
    dirname=$(dirname "$file")
    extension="${filename##*.}"
    basename="${filename%.*}"

    # Create new filename
    if [ "$extension" = "$filename" ]; then
      # No extension
      newname="${PREFIX}_${basename}_${TIMESTAMP}"
    else
      # Has extension
      newname="${PREFIX}_${basename}_${TIMESTAMP}.${extension}"
    fi

    # Create target directory structure
    reldir="${dirname#${MOUNT_POINT}}"
    mkdir -p "/data/minio-backup${reldir}"

    # Process file based on extension
    target_file="/data/minio-backup${reldir}/${newname}"
    
    # Check if file already processed (avoid duplicates)
    processed_marker="/tmp/processed_$(echo "$file" | md5sum | cut -d' ' -f1)"
    
    if [ ! -f "$processed_marker" ]; then
      if [ "$extension" = "csv" ]; then
        # Add header for CSV files
        echo "${HEADER}" > "$target_file"
        cat "$file" >> "$target_file"
      else
        # Just copy non-CSV files
        cp "$file" "$target_file"
      fi
      
      # Mark as processed
      touch "$processed_marker"
      echo "[${TIMESTAMP}] Processed: $filename -> $newname"
    fi
  done
  
  # Check every 5 seconds for new files
  sleep 5
done