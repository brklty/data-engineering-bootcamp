#!/bin/bash

RAW_DIR="raw"
PROCESSED_DIR="processed"
LOG_DIR="logs"
LOG_FILE="$LOG_DIR/pipeline.log"

mkdir -p "$PROCESSED_DIR" "$LOG_DIR"

echo "$(date '+%Y-%m-%d %H:%M:%S') - Pipeline started" | tee -a "$LOG_FILE"

if [ ! -d "$RAW_DIR" ]; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') - ERROR: Raw directory not found" | tee -a "$LOG_FILE"
    exit 1
fi

echo "Raw directory found"


for file in "$RAW_DIR"/*.csv
do
    echo "Checking: $file"

    row_count=$(wc -l < "$file")

    if [ "$row_count" -eq 0 ]; then
        echo "$(date '+%Y-%m-%d %H:%M:%S') - WARNING: Empty file: $file" | tee -a "$LOG_FILE"
    else
        echo "$(date '+%Y-%m-%d %H:%M:%S') - VALID: $file ($row_count rows)" | tee -a "$LOG_FILE"

        filename=$(basename "$file" .csv)

        cp "$file" "$PROCESSED_DIR/${filename}_clean.csv"

        echo "$(date '+%Y-%m-%d %H:%M:%S') - PROCESSED: ${filename}_clean.csv" | tee -a "$LOG_FILE"
    fi
done

echo "$(date '+%Y-%m-%d %H:%M:%S') - Pipeline finished" | tee -a "$LOG_FILE"