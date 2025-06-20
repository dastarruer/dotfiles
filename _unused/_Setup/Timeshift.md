# USE A USB DO NOT WIPE EVERYTHING
This is so that the drives are unmounted and you can't damage them
Also backup important stuff just in case.

1. After installing gparted, open live environment and launch **gparted**.
2. Right click partition, and resize so there is 20GB of space left.
3. Right click unallocated space and label it Timeshift.
4. Apply changes and pray
5. Reboot, and setup Timeshift.

Launch timeshift with 
```bash
sudo timeshift-gtk
```
Setup timeshift and you're done!