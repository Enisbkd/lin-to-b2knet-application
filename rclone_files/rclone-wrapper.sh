#!/bin/sh

#
# Rclone sync script with prefix + timestamp and deletion sync (POSIX /bin/sh)
# - Mirrors MinIO bucket locally via rclone
# - For each source file, creates exactly one prefixed+timestamped copy (only once)
# - For CSV files, prepends a fixed header when copying
# - Cleans up destination files when their corresponding source is deleted
#

set -eu

PREFIX="b2knetIn"
SRC_REMOTE="minio:kafka-sink/topics/"
TEMP_SYNC_DIR="/tmp/minio-sync"        # Mirror of MinIO
DESTINATION_DIR="/data/minio-backup"   # Where renamed files go
RCLONE_CONFIG="/config/rclone.conf"
LOG_FILE="/logs/rclone_sync.log"
SYNC_INTERVAL=10
LOCK_FILE="/tmp/rclone_sync.lock"
TRACKING_FILE="/tmp/rclone_processed_files.txt"  # Track processed files

HEADER="Code;CardCode;LastName;FirstName;CategoryCode;CategoryDescription;FunctionCode;FunctionDescription;ShiftCode;ShiftDescription;Gender;LANGUAGE;ChangeSize;ContractStart;ContractEnd;DisableDate;Mag;PrimaryMag;"

log_message() {
  ts=$(date "+%Y-%m-%d %H:%M:%S")
  echo "[$ts] $1" | tee -a "$LOG_FILE"
}

handle_error() {
  log_message "ERROR: $1"
  release_lock
  exit 1
}

check_dependencies() {
  if ! command -v rclone >/dev/null 2>&1; then
    handle_error "rclone not found in PATH."
  fi
}

check_or_create_directories() {
  mkdir -p "$DESTINATION_DIR" "$TEMP_SYNC_DIR"
  touch "$TRACKING_FILE"
}

acquire_lock() {
  if [ -f "$LOCK_FILE" ]; then
    log_message "Another instance is running. Exiting."
    exit 1
  fi
  touch "$LOCK_FILE"
}

release_lock() {
  rm -f "$LOCK_FILE" 2>/dev/null || true
}

sync_source() {
  log_message "Starting rclone sync to temporary directory..."
  rclone sync "$SRC_REMOTE" "$TEMP_SYNC_DIR" \
    --config "$RCLONE_CONFIG" \
    --delete-during \
    --create-empty-src-dirs \
    --log-file "$LOG_FILE" \
    --log-level INFO
}

process_new_or_changed_files() {
  log_message "Processing source files for prefix + timestamp..."

  find "$TEMP_SYNC_DIR" -type f | while IFS= read -r src_file; do
    rel_path=${src_file#$TEMP_SYNC_DIR/}

    # Check if this file has already been processed
    if grep -Fxq "$rel_path" "$TRACKING_FILE" 2>/dev/null; then
      # File already processed, skip
      continue
    fi

    rel_dir=$(dirname "$rel_path")
    orig_filename=$(basename "$rel_path")

    # Safely determine extension and base name
    extension=""
    basename_noext="$orig_filename"
    case "$orig_filename" in
      *.*)
        extension="${orig_filename##*.}"
        basename_noext="${orig_filename%.*}"
        ;;
    esac

    # Lowercase extension for case-insensitive comparison
    ext_lc=$(printf '%s' "$extension" | tr 'A-Z' 'a-z')

    dest_dir="$DESTINATION_DIR/$rel_dir"
    mkdir -p "$dest_dir"

    # Create file with current timestamp
    timestamp=$(date "+%Y%m%d%H%M%S")
    if [ -n "$extension" ]; then
      newname="${PREFIX}_${timestamp}_${basename_noext}.$extension"
    else
      newname="${PREFIX}_${timestamp}_${basename_noext}"
    fi

    dest_path="$dest_dir/$newname"

    # Always copy full content; for CSV, prepend header
    if [ "$ext_lc" = "csv" ]; then
      {
        printf '%s\n' "$HEADER"
        cat "$src_file"
      } > "$dest_path"
      log_message "Created CSV with header: $dest_path"
    else
      cp "$src_file" "$dest_path"
      log_message "Created: $dest_path"
    fi

    src_size=$(wc -c < "$src_file" 2>/dev/null || echo 0)
    dest_size=$(wc -c < "$dest_path" 2>/dev/null || echo 0)
    log_message "  Source size: $src_size bytes, Destination size: $dest_size bytes"

    # Mark this file as processed
    echo "$rel_path" >> "$TRACKING_FILE"
  done
}

cleanup_deleted_files() {
  log_message "Cleaning up destination files with no corresponding source..."

  find "$DESTINATION_DIR" -type f -name "${PREFIX}_*" 2>/dev/null | while IFS= read -r dest_file; do
    dest_rel_path=${dest_file#$DESTINATION_DIR/}
    rel_dir=$(dirname "$dest_rel_path")
    fname=$(basename "$dest_rel_path")

    extension=""
    fname_noext="$fname"
    case "$fname" in
      *.*)
        extension="${fname##*.}"
        fname_noext="${fname%.*}"
        ;;
    esac

    # Strip leading PREFIX_
    core=${fname_noext#${PREFIX}_}

    # core is "YYYYMMDDHHMMSS_originalname"
    # Remove leading timestamp by cutting off before the first underscore
    base_without_ts=${core#*_}

    if [ -n "$extension" ]; then
      src_candidate="$TEMP_SYNC_DIR/$rel_dir/$base_without_ts.$extension"
      rel_path_to_remove="$rel_dir/$base_without_ts.$extension"
    else
      src_candidate="$TEMP_SYNC_DIR/$rel_dir/$base_without_ts"
      rel_path_to_remove="$rel_dir/$base_without_ts"
    fi

    if [ ! -f "$src_candidate" ]; then
      rm -f "$dest_file"
      log_message "Deleted destination file without source: $dest_file"

      # Remove from tracking file (using temp file for portability)
      grep -Fxv "$rel_path_to_remove" "$TRACKING_FILE" > "${TRACKING_FILE}.tmp" 2>/dev/null || true
      mv "${TRACKING_FILE}.tmp" "$TRACKING_FILE"
    fi
  done
}

main_loop() {
  while true; do
    sync_source
    process_new_or_changed_files
    cleanup_deleted_files
    log_message "Waiting ${SYNC_INTERVAL}s before the next sync..."
    sleep "$SYNC_INTERVAL"
  done
}

trap 'release_lock; log_message "Script terminated."; exit 0' INT TERM
trap 'handle_error "Script encountered a fatal error and exited."' ERR

main() {
  log_message "Initializing rclone sync script (with prefix + timestamp + deletion sync + CSV header)..."
  check_dependencies
  check_or_create_directories
  acquire_lock
  main_loop
}

main
