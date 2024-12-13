FROM ubuntu:bionic

ENV DEBIAN_FRONTEND=noninteractive

# 필수 패키지 설치
RUN apt-get update -y && apt-get install -y \
    software-properties-common \
    python3.8 python3-pip openjdk-8-jdk \
    python git-core gnupg flex bison gperf build-essential \
    zip curl gawk liblz4-tool zlib1g-dev gcc-multilib g++-multilib libc6-dev-i386 \
    lib32ncurses5 lib32ncurses5-dev x11proto-core-dev libx11-dev lib32z-dev ccache \
    libgl1-mesa-dev libxml2-utils xsltproc unzip mtools u-boot-tools \
    htop iotop sysstat iftop pigz bc device-tree-compiler lunzip \
    dosfstools vim-common parted udev libssl-dev sudo rsync python3-pyelftools cpio

# Python 3.8을 기본 python3로 설정
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.8 1

# repo 설치
RUN curl https://mirrors.tuna.tsinghua.edu.cn/git/git-repo > /usr/local/bin/repo && \
    chmod +x /usr/local/bin/repo && \
    which repo

# 사용자 추가
ENV USER=android11-docker
ARG USER_ID=1000
ARG GROUP_ID=1000
RUN groupadd -g ${GROUP_ID} ${USER} && useradd -m -g ${USER} -u ${USER_ID} ${USER}

USER android11-docker

WORKDIR /android11
RUN repo init -u https://github.com/radxa/manifests.git -b Android11_Radxa_rk11 -m rockchip-r-release.xml
RUN repo sync -d --no-tags -j4

USER root

COPY ./build_android.sh ./
RUN chmod +x ./build_android.sh

COPY ./mkgpt.sh ./
RUN chmod +x ./mkgpt.sh

USER android11-docker
CMD ./build_android.sh
