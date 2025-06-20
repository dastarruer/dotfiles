#!/usr/bin/env bash

sudo apt update
sudo apt upgrade -y
sudo apt autoremove -y
flatpak update -y
pipx upgrade-all
spicetify update
spicetify restore backup apply
