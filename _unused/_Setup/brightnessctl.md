To give write permissions for device files:

1. Check the group name 
```bash
ls -l /sys/class/backlight/*/brightness
# Output:
# -rw-rw-r-- 1 root video 4096 Jan 22 11:32 /sys/class/backlight/amdgpu_bl1/brightness
```

2. Add your user to the group name:
```
sudo usermod -aG video $USER
```

3. Reboot