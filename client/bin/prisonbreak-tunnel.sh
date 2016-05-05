#!/usr/bin/env sh

exec ssh -N -D 0.0.0.0:1080 \
         -i ~/.ssh/identity -o StrictHostKeyChecking=no \
         -p ${SSH_PORT:-22} \
         ${SSH_USER:-tunnel}@${SSH_HOST:-prison}