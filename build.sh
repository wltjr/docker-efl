#!/bin/bash
# Copyright 2019 Obsidian-Studios, Inc.
# Author William L. Thomson Jr.
#        wlt@o-sinc.com
#
# Distributed under the terms of The GNU Public License v3.0 (GPLv3)

CPUC=$(awk '/^processor/{n+=1}END{print n}' /proc/cpuinfo)
PATH="~/.local/bin:${PATH}"

apt update
apt-get install -y \
	automake \
	autopoint \
	build-essential \
	ccache \
	check \
	clang \
	cmake \
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
	libcogl-gles2-dev \
	libcups2 \
	libcupsfilters1 \
	libcupsimage2 \
	libdbus-1-dev \
	libflac-dev \
	libfontconfig1-dev \
	libfreetype6-dev \
	libfribidi-dev \
	libgcrypt20 \
	libgcrypt20-dev \
	libgif-dev \
	libgs9 \
	libgs9-common \
	libgstreamer1.0-dev \
	libgstreamer-plugins-base1.0-dev \
	libgnutls30 \
	libgnutls28-dev \
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
	libpoppler73 \
	libpoppler-cpp0v5 \
	libpoppler-cpp-dev \
	libpoppler-dev \
	libpoppler-private-dev \
	libproxy-dev \
	libpulse-dev \
	libpulse-mainloop-glib0 \
	libraw16 \
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
	libwebp6 \
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
	ninja-build \
	poppler-data \
	python3-chardet \
	python3-colorama \
	python3-distlib \
	python3-html5lib \
	python3-pip \
	python3-pkg-resources \
	python3-requests \
	python3-setuptools \
	python3-six \
	python3-urllib3 \
	python3-wheel \
	python-pip-whl \
	rpm \
	texlive-base \
	udev \
	unity-greeter-badges \
	valgrind

pip3 install --user meson

# download EFL, unpack into /src, compile will take place in /build
curl -L -o /tmp/efl.txz -L "${EFL_URL}"
mkdir /build /src
cd /src
tar --strip=1 -xJf /tmp/efl.txz
cd ../
rm -v /tmp/efl.txz

# configure
meson \
	--buildtype debug \
	--libdir lib64 \
	--localstatedir /var/lib \
	--prefix /usr \
	--sysconfdir /etc \
	--wrap-mode nodownload \
	-Dcrypto=gnutls \
	-Dopengl=es-egl \
	-Demotion-loaders-disabler=gstreamer,gstreamer1,libvlc \
	-Devas-loaders-disabler=json,xcf,dds,tga,raw \
	-Decore-imf-loaders-disabler=ibus,scim,xim \
	-Demotion-generic-loaders-disabler=vlc \
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
	-Dsystemd=false \
	-Dpulseaudio=true \
	-Dnetwork-backend=none \
	-Dxpresent=false \
	-Dxgesture=false \
	-Dxinput2=true \
	-Dxinput22=true \
	-Dtslib=false \
	-Deject-path=detect \
	-Dmount-path=detect \
	-Dunmount-path=detect \
	-Devas-modules=shared \
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
	-Delogind=false \
	-Ddictionaries-hyphen-dir=/usr/share/hyphen/ \
	-Delementary-base-dir=.elementary \
	-Dinstall-eo-files=false \
	/build \
	/src

# compile and install
ninja -C /build && ninja -C /build install

# clean up after build
rm -r /build /src
