#!/bin/sh

yum -y install gcc-c++.x86_64 \
    vim-enhanced \
    wget \
    libcurl-devel \
	gcc-gfortran \
    tbb-devel \
    devtoolset-8-gcc-gfortran.x86_64 \
    ncurses-libs \
	imake.x86_64 \
	java-1.7.0-openjdk-devel.x86_64 \
	libXp.x86_64 \
	libXpm-devel.x86_64 \
	make.x86_64 \
	motif-devel.x86_64 \
	ncurses-devel.x86_64 \
	tcsh.x86_64 \
	xterm-295-3.el7.x86_64 \
	boost-devel.x86_64 \
	libcurl-devel.x86_64 \
	libtiff-devel.x86_64 \
	libxml2-devel.x86_64 \
	patch.x86_64 \
	pcre-devel.x86_64 \
	postgresql-devel.x86_64 \
	sqlite-devel.x86_64 \
	unixODBC.x86_64 && yum -y clean all

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