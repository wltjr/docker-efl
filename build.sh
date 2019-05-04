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

curl -L -o efl.txz -L "${EFL_URL}"
tar --strip=1 -xJf efl.txz

./configure \
	--prefix=/usr \
	--mandir=/usr/share/man \
	--infodir=/usr/share/info \
	--datadir=/usr/share \
	--sysconfdir=/etc \
	--localstatedir=/var/lib \
	--docdir=/usr/share/doc/efl \
	--htmldir=/usr/share/doc/efl/html \
	--libdir=/usr/lib64 \
	--disable-avahi \
	--disable-cxx-bindings \
	--disable-dependency-tracking \
	--disable-doc \
	--disable-fb \
	--disable-fribidi \
	--disable-gesture \
	--disable-gstreamer \
	--disable-gstreamer1 \
	--disable-ibus \
	--disable-image-loader-tga \
	--disable-libraw \
	--disable-lua-old \
	--disable-neon \
	--disable-pixman \
	--disable-pixman-font \
	--disable-pixman-image \
	--disable-pixman-image-scale-sample \
	--disable-pixman-line \
	--disable-pixman-poly \
	--disable-pixman-rect \
	--disable-scim \
	--disable-sdl \
	--disable-silent-rules \
	--disable-static \
	--disable-systemd \
	--disable-tizen \
	--disable-tslib \
	--disable-xim \
	--disable-xpresent \
	--enable-audio \
	--enable-drm \
	--enable-egl \
	--enable-elogind \
	--enable-elput \
	--enable-fontconfig \
	--enable-gl-drm \
	--enable-harfbuzz \
	--enable-image-loader-bmp \
	--enable-image-loader-eet \
	--enable-image-loader-generic \
	--enable-image-loader-gif \
	--enable-image-loader-ico \
	--enable-image-loader-ico \
	--enable-image-loader-jp2k \
	--enable-image-loader-jpeg \
	--enable-image-loader-pmaps \
	--enable-image-loader-png \
	--enable-image-loader-psd \
	--enable-image-loader-tga \
	--enable-image-loader-tiff \
	--enable-image-loader-wbmp \
	--enable-image-loader-wbmp \
	--enable-image-loader-webp \
	--enable-image-loader-xpm \
	--enable-libmount \
	--enable-librsvg \
	--enable-multisense \
	--enable-nls \
	--enable-physics \
	--enable-poppler \
	--enable-pulseaudio \
	--enable-spectre \
	--enable-threads \
	--enable-v4l2 \
	--enable-wayland \
	--enable-xine \
	--enable-xinput22 \
	--with-crypto=gnutls \
	--with-glib=yes \
	--with-opengl=es \
	--with-profile=release \
	--with-tests=none \
	--with-x \
	--with-x11=xlib

make -j${CPUC}
make install
