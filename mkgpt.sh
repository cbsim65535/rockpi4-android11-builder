#!/bin/bash
mv Image-* Image
cp ../RKTools/linux/Linux_Pack_Firmware/rockdev/android-gpt.sh ./rockdev/
chmod +x android-gpt.sh
cd rockdev && ./android-gpt.sh
