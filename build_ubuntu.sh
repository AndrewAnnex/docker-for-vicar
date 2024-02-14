#!/bin/sh

#export DEBIAN_FRONTEND=noninteractive

apt-get update && apt-get install --yes software-properties-common
add-apt-repository -y ppa:zeehio/libxp

apt-get install --yes \
    wget \
	tcsh \
	libtbb2 \
	libncurses5-dev \
	build-essential \
	gfortran \
	xorg-dev \
	xserver-xorg-dev \
	libmotif-dev \
	libmotif-common \
	libxp6 \
	openjdk-17-jre \
	&& rm -rf /var/lib/apt/lists/*



# download vicar and do setup
cd tmp
wget https://github.com/NASA-AMMOS/VICAR/releases/download/5.0/vicar_open_bin_x86-64-linx_5.0.tar.gz
tar -xf vicar_open_bin_x86-64-linx_5.0.tar.gz
# move to /vos and /external
mv vicar_open_bin_x86-64-linx_5/vicar_open_5.0 /vos
mv vicar_open_bin_x86-64-linx_5/vicar_open_ext_x86-64-linx_5.0 /external
# clean up
rm vicar_open_bin_x86-64-linx_5.0.tar.gz
cd /
# make /data
mkdir /data