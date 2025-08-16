#!/usr/bin/env bash

# Get raw total and used memory with units (e.g., 7.5Gi, 2.3Gi)
read total used <<< $(free -h | awk '/^Mem:/ {print $2, $3}')

# Function to add 'B' after 'i' if missing
add_b() {
  if [[ $1 =~ [0-9\.]+Gi$ ]]; then
    echo "${1}B"
  elif [[ $1 =~ [0-9\.]+Mi$ ]]; then
    echo "${1}B"
  else
    echo "$1"
  fi
}

total_gib=$(add_b "$total")
used_gib=$(add_b "$used")

# Get raw total and used memory in kilobytes for calculation
read total_kb used_kb <<< $(free | awk '/^Mem:/ {print $2, $3}')

# Calculate used memory percentage (rounded)
memory_used_percentage=$(( 100 * used_kb / total_kb ))

# Output JSON for Waybar
echo "{\"text\": \"$used_gib\", \"tooltip\": \"$used_gib out of $total_gib used ($memory_used_percentage%)\"}"
