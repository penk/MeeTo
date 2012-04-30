#!/bin/bash

dd if=../uRamdisk.cm7 of=../ramdisk.cpio.gz bs=64 skip=1 
cat ../ramdisk.cpio.gz | gzip -d | cpio -i 
