#!/bin/bash

find . -regex "./.*"| cpio -ov -H newc | gzip > ../repacked-ramdisk.cpio.gz 
mkimage -A ARM -T RAMDisk -n Image -d ../repacked-ramdisk.cpio.gz ../uRamdisk_new_cm7
sudo cp ../uRamdisk_new_cm7 /media/sf_vm/
