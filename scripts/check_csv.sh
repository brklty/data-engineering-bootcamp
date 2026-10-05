#!/bin/bash

for file in ../raw/*.csv
do
    if [ -f "$file" ]; then
        echo "Found: $file"
        echo "Rows: $(wc -l < "$file")"
    fi
done