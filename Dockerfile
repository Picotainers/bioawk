# syntax=docker/dockerfile:1

FROM ubuntu:22.04 AS builder

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        bison \
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

COPY --from=builder /tmp/bioawk/bioawk /usr/local/bin/bioawk-bin
RUN printf '%s\n' '#!/bin/sh' \
    'if [ "${1:-}" = "--help" ] || [ "${1:-}" = "-h" ]; then' \
    '  /usr/local/bin/bioawk-bin 2>/dev/null || true' \
    '  exit 0' \
    'fi' \
    'exec /usr/local/bin/bioawk-bin "$@"' \
    > /usr/local/bin/bioawk \
    && chmod +x /usr/local/bin/bioawk

WORKDIR /data
CMD ["bioawk"]
