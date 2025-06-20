#!/usr/bin/env bash

if [ -z "$1" ]; then
  echo "Output dir is missing!"
  exit 1
fi

# Hardcode input and output directories
input_dir="$HOME/Videos/to-convert/"
output_dir="$HOME/Videos/converted/"

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
for input_file in "$input_dir"*; do
  if [[ "$input_file" == *.mkv || "$input_file" == *.avi || "$input_file" == *.mov ]]; then
    # Set the output file path
    output_file="$output_dir$(basename "$input_file" | sed 's/\.[^.]*$/.mp4/')"

    # Convert the file with ffmpeg and log the output
    ffmpeg -hide_banner -vaapi_device /dev/dri/renderD128 \
      -i "$input_file" \
      -vf 'format=nv12,hwupload' \
      -c:v hevc_vaapi -b:v 2500k -maxrate 5000k -bufsize 10000k \
      -c:a aac -b:a 96k -movflags +faststart \
      "$output_file"

  fi
done
echo "Moving media to $1..."
sudo mv "$output_dir*" "$1"
echo "Done!"