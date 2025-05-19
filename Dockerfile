FROM ubuntu:noble

LABEL maintainer="w@wltjr.com"

ENV EFL_URL="https://download.enlightenment.org/rel/libs/efl/efl-1.28.1.tar.xz"

# update base system
RUN apt-get -qq update && apt-get -qq upgrade -y --no-install-recommends

# install packages
RUN apt-get -qq install -y \
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
	libblkid-dev \
	libbluetooth-dev \
	libbullet-dev \
	libc6 \
	libc6-dev \
	libc-dev-bin \
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
    psmisc \
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
	udev \
    unzip \
	valgrind \
    xorg \
    xserver-xorg-video-dummy

# download, build, and install efl
COPY build.sh ./build.sh
RUN chmod +x ./build.sh && sync && ./build.sh

# download and setup sonar-cube's build-wrapper and sonar-scanner
COPY sonar.sh ./sonar.sh
RUN chmod +x ./sonar.sh && sync && ./sonar.sh
