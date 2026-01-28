#!/bin/bash
# Copyright 2026 William L. Thomson Jr. <w@wltjr.com>
#
# Distributed under the terms of The GNU Public License v3.0 (GPLv3)

# edit commented version and commit to update the build-wrapper version
#
# use analyzer/build-wrapper version 6.77.0.95488
#
# download, unpack and relocate build-wrapper-linux-x86-64
curl -JLO -k https://sonarcloud.io/static/cpp/build-wrapper-linux-x86.zip
unzip -jq build-wrapper-linux-x86.zip
mv -v build-wrapper-linux-x86-64 /usr/bin
# needed for use in github actions, fails in /usr/lib/x86_64-linux-gnu
mv -v lib*.so /usr/bin

# download and unpack sonar-scanner
sv=8.0.1.6346
curl -k -L -o sonar-scanner-cli-linux-x64.zip \
	-L https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-${sv}-linux-x64.zip
unzip -q sonar-scanner-cli-linux-x64.zip \
	-d sonar-scanner-linux-x64
echo "export PATH=/sonar-scanner-linux-x64/bin:${PATH}" >> /root/.bashrc

rm *.zip
