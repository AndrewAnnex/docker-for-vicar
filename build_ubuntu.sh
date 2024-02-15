#!/bin/sh

#export DEBIAN_FRONTEND=noninteractive

apt-get update && apt-get install --yes software-properties-common
add-apt-repository -y ppa:zeehio/libxp

apt-get install --yes \
    wget \
    vim \
	tcsh \
    libcurl4-openssl-dev \
	libtbb2 \
	libncurses5-dev \
	build-essential \
	gfortran \
	xorg-dev \
    xutils-dev \
	xserver-xorg-dev \
	libmotif-dev \
	libmotif-common \
	libxp6 \
	openjdk-17-jre \
	&& rm -rf /var/lib/apt/lists/*

# download vicar and do setup
mkdir /data
cd /tmp
wget https://github.com/NASA-AMMOS/VICAR/releases/download/5.0/vicar_open_bin_x86-64-linx_5.0.tar.gz
tar -xf vicar_open_bin_x86-64-linx_5.0.tar.gz
# move to /vos and /external
mv /tmp/vicar_open_bin_x86-64-linx_5.0/vicar_open_5.0 /vos
mv /tmp/vicar_open_bin_x86-64-linx_5.0/vicar_open_ext_x86-64-linx_5.0 /external
# clean up
rm /tmp/vicar_open_bin_x86-64-linx_5.0.tar.gz
cd /
chmod 777 /data
chmod -R 777 /vos
chmod -R 777 /external