FROM ubuntu:noble

LABEL maintainer="w@wltjr.com"

ENV EFL_URL="https://download.enlightenment.org/rel/libs/efl/efl-1.27.0.tar.xz"

COPY build.sh ./build.sh

RUN chmod +x ./build.sh && \
    sync && \
    ./build.sh
