#!/bin/bash
# Copyright 2024 William L. Thomson Jr. <w@wltjr.com>
#
# Distributed under the terms of The GNU Public License v3.0 (GPLv3)

CPUC=$(awk '/^processor/{n+=1}END{print n}' /proc/cpuinfo)
PATH="~/.local/bin:${PATH}"

# download EFL, unpack into src, compile will take place in build
curl -L -o /tmp/efl.txz -L "${EFL_URL}"
mkdir /tmp/efl
cd /tmp/efl
mkdir build src
cd src
tar --strip=1 -xJf /tmp/efl.txz
cd ../
rm -v /tmp/efl.txz

# configure
meson setup \
	--buildtype debug \
	--localstatedir /var/lib \
	--prefix /usr \
	--sysconfdir /etc \
	--wrap-mode nodownload \
	-Dcrypto=openssl \
	-Dopengl=es-egl \
	-Dbindings= \
	-Devas-loaders-disabler=json,xcf,dds,heif,tga,avif,jxl,raw \
	-Decore-imf-loaders-disabler=ibus,scim,xim \
	-Daudio=true \
	-Davahi=false \
	-Dx11=true \
	-Dfb=false \
	-Dsdl=false \
	-Dwl=true \
	-Dbuffer=false \
	-Ddrm=true \
	-Dcocoa=false \
	-Dphysics=true \
	-Deeze=true \
	-Deina-magic-debug=true \
	-Ddebug-threads=false \
	-Dbuild-examples=false \
	-Dbuild-tests=false \
	-Dglib=true \
	-Dg-mainloop=false \
	-Dgstreamer=true \
	-Dpulseaudio=true \
	-Dnetwork-backend=none \
	-Dxpresent=false \
	-Dinput=true \
	-Dxinput2=true \
	-Dxinput22=true \
	-Dtslib=false \
	-Deject-path=detect \
	-Dmount-path=detect \
	-Dunmount-path=detect \
	-Dharfbuzz=true \
	-Dfribidi=false \
	-Dfontconfig=true \
	-Dedje-sound-and-video=true \
	-Dpixman=false \
	-Dhyphen=false \
	-Dembedded-lz4=false \
	-Dlibmount=true \
	-Dvnc-server=false \
	-Dv4l2=true \
	-Dwl-deprecated=false \
	-Ddrm-deprecated=false \
	-Dnls=true \
	-Dmono-beta=false \
	-Dnative-arch-optimization=true \
	-Dsystemd=true \
	-Ddictionaries-hyphen-dir=/usr/share/hyphen/ \
	-Delementary-base-dir=.elementary \
	-Dlua-interpreter=luajit \
	-Dinstall-eo-files=false \
	build \
	src

# compile, install, and clean up after build
ninja -C build -j${CPUC} && ninja -C build install && rm -r /tmp/efl
