FROM ubuntu:18.04

LABEL maintainer="wlt@o-sinc.com"

ENV EFL_URL="https://download.enlightenment.org/rel/libs/efl/efl-1.23.3.tar.xz"

COPY build.sh ./build.sh

RUN chmod +x ./build.sh && \
    sync && \
    ./build.sh
