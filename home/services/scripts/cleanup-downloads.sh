#!/usr/bin/env bash

# Delete files older than five days in the downloads dir
find $HOME/Downloads -mindepth 1 -mtime +5 -delete

