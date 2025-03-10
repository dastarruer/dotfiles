#!/bin/bash

# Use fzf to choose input directory
input_dir=/media/to_convert

# Use fzf to choose output directory
output_dir=$1

# Loop through all video files in the selected input directory
for input_file in "$input_dir"/*; do
  if [[ "$input_file" == *.mkv || "$input_file" == *.avi || "$input_file" == *.mov ]]; then
    output_file="$output_dir/$(basename "$input_file" | sed 's/\.[^.]*$/.mp4/')"
    echo "Converting $input_file to $output_file"
    
    ffmpeg -v warning -i "$input_file" -c:v libx264 -c:a aac -strict experimental "$output_file" > /var/log/convert_media$(date +'%Y-%m-%d_%H-%M-%S').log 2>&1
  fi
done
