# syntax=docker/dockerfile:1

FROM ubuntu:22.04 AS builder

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        build-essential \
        ca-certificates \
        git \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /tmp
RUN git clone --depth 1 https://github.com/lh3/bioawk.git \
    && make -C /tmp/bioawk

FROM ubuntu:22.04

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
    && rm -rf /var/lib/apt/lists/*

COPY --from=builder /tmp/bioawk/bioawk /usr/local/bin/bioawk

WORKDIR /data
ENTRYPOINT ["/usr/local/bin/bioawk"]
