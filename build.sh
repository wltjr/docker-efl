#!/bin/bash
# Copyright 2024 William L. Thomson Jr. <w@wltjr.com>
#
# Distributed under the terms of The GNU Public License v3.0 (GPLv3)

CPUC=$(awk '/^processor/{n+=1}END{print n}' /proc/cpuinfo)
PATH="~/.local/bin:${PATH}"

# update base system
apt-get update && apt-get upgrade -y --no-install-recommends

# install packages
apt-get install -y \
	automake \
	autopoint \
	build-essential \
	ccache \
	check \
	clang \
	cmake \
	curl \
	dpkg-dev \
	doxygen \
	git \
	gnutls-bin \
	imagemagick \
	libasound2-dev \
	libavahi-client3 \
	libavahi-client-dev \
	libavahi-common3 \
	libavahi-common-dev \
	libblkid-dev \
	libbluetooth-dev \
	libbullet-dev \
	libc6 \
	libc6-dev \
	libc-dev-bin \
	libcups2 \
	libcupsfilters2t64 \
	libcupsimage2 \
	libdbus-1-dev \
	libflac-dev \
	libfontconfig1-dev \
	libfreetype6-dev \
	libfribidi-dev \
	libgcrypt20 \
	libgcrypt20-dev \
	libgif-dev \
	libgles-dev \
	libgs10 \
	libgs10-common \
	libgstreamer1.0-dev \
	libgstreamer-plugins-base1.0-dev \
	libharfbuzz-dev \
	libharfbuzz-gobject0 \
	libharfbuzz-icu0 \
	libibus-1.0-dev \
	libiconv-hook-dev \
	libijs-0.35 \
	libinput-dev \
	libjbig2dec0 \
	libjpeg-dev \
	libluajit-5.1-2 \
	libluajit-5.1-common \
	libluajit-5.1-dev \
	liblz4-dev \
	libmount-dev \
	libogg-dev \
	libopenjp2-7-dev \
	libpam0g-dev \
	libpaper1 \
	libpaper-utils \
	libpoppler134 \
	libpoppler-cpp0v5 \
	libpoppler-cpp-dev \
	libpoppler-dev \
	libpoppler-private-dev \
	libproxy-dev \
	libpulse-dev \
	libpulse-mainloop-glib0 \
	libraw23t64 \
	libraw-dev \
	librsvg2-dev \
	libscim-dev \
	libsndfile1-dev \
	libspectre1 \
	libspectre-dev \
	libssl-dev \
	libsystemd-dev \
	libtiff5-dev \
	libtool \
	libudev1 \
	libudev-dev \
	libudisks2-dev \
	libunibreak-dev \
	libunwind-dev \
	libvlc-dev \
	libvorbis0a \
	libvorbis-dev \
	libvorbisenc2 \
	libvorbisfile3 \
	libwebp7 \
	libwebp-dev \
	libxcb-keysyms1-dev \
	libxcursor-dev \
	libxine2-dev \
	libxinerama-dev \
	libxkbcommon0 \
	libxkbcommon-dev \
	libxkbcommon-x11-0 \
	libxkbcommon-x11-dev \
	libxkbfile-dev \
	libxrandr-dev \
	libxss-dev \
	libxtst-dev \
	linux-tools-common \
	lua5.2 \
	meson \
	ninja-build \
	openssl \
	poppler-data \
	python3-chardet \
	python3-colorama \
	python3-distlib \
	python3-html5lib \
	python3-pkg-resources \
	python3-requests \
	python3-setuptools \
	python3-six \
	python3-urllib3 \
	python3-wheel \
	rpm \
	texlive-base \
	udev \
	unity-greeter-badges \
	valgrind

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
