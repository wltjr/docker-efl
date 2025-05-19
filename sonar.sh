#!/bin/bash
# Copyright 2025 William L. Thomson Jr. <w@wltjr.com>
#
# Distributed under the terms of The GNU Public License v3.0 (GPLv3)

# download, unpack and relocate build-wrapper-linux-x86-64
curl -JLO -k https://sonarcloud.io/static/cpp/build-wrapper-linux-x86.zip
unzip -jq build-wrapper-linux-x86.zip
mv -v build-wrapper-linux-x86-64 /usr/bin
# needed for use in github actions, fails in /usr/lib/x86_64-linux-gnu
cp -v lib*.so /usr/bin

# download and unpack sonar-scanner
curl -JLO -k https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-7.1.0.4889-linux-x64.zip
unzip -q sonar-scanner-cli-7.1.0.4889-linux-x64.zip
echo "export PATH=/sonar-scanner-7.1.0.4889-linux-x64/bin:${PATH}" >> /root/.bashrc

rm *.zip
