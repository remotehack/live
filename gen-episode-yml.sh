#!/bin/bash
# Check if running on macOS
if [[ $(uname) != "Darwin" ]]; then
    echo "This script is intended to run on macOS."
    exit 1
fi
# Input: Path to the .m4a file
file_path="$1"
# Optional: Publication date as the second argument
pubDate_arg="$2"

# Extract episode number using grep and sed
episode_number=$(echo "$file_path" | grep -o 'episode-[0-9]*' | sed 's/episode-//')

# Use the provided publication date or generate the current date
if [[ -n "$pubDate_arg" ]]; then
    pubDate="$pubDate_arg"
else
    pubDate=$(date -u +"%A, %d %B %Y %T +0000")
fi

# Extract duration using afinfo and format it
duration=$(afinfo "$file_path" | grep duration | awk '{seconds=$3; hours=int(seconds/3600); minutes=int((seconds%3600)/60); seconds=int(seconds%60); printf "%02d:%02d:%02d\n", hours, minutes, seconds}')

# Extract file size using stat
length=$(stat -f%z "$file_path")


# Generate YAML content
cat <<EOF > "episodes/${episode_number}.yml"
---
title: Episode $episode_number - 
description: ""
pubDate: '$pubDate'
duration: '$duration'
length: $length
---
EOF

echo "Generated YAML file for episode $episode_number."