#!/bin/bash

if [ -z "$1" ]; then
  echo "Show name is missing!"
  exit 1
fi

# Hardcode input and output directories
input_dir="~/Videos/to_convert/"
output_dir="/media/jellyfin/shows/$1"

# Check if input directory exists
if [ ! -d "$input_dir" ]; then
  echo "Input directory does not exist. Exiting."
  exit 1
fi

# Check if output directory exists
if [ ! -d "$output_dir" ]; then
  echo "Output directory does not exist. Exiting."
  exit 1
fi

# Loop through all video files in the input directory
for input_file in "$input_dir"/*; do
  if [[ "$input_file" == *.mkv || "$input_file" == *.avi || "$input_file" == *.mov ]]; then
    # Set the output file path
    output_file="$output_dir/$(basename "$input_file" | sed 's/\.[^.]*$/.mp4/')"
    
    # Set log file path
    log_file="$output_dir/$(basename "$input_file" | sed 's/\.[^.]*$/.log/')"
    
    # Convert the file with ffmpeg and log the output
    ffmpeg -hide_banner -v error -i "$input_file" -c:v libx264 -c:a aac "$output_file" > "$log_file" 2>&1
  fi
done
