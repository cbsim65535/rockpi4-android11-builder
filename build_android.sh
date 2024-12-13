#!/bin/bash

# 환경 변수 설정
source build/envsetup.sh

# 빌드 설정
lunch rk3399_ROCKPI4B_Android11-userdebug

# 빌드 시작
./build.sh -UACKup
