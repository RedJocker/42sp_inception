#!/bin/sh

port=${WORDPRESS_PORT:-9000}
hex_port=$(printf "%04X" "$port")
echo $hex_port
if grep -q "$hex_port" /proc/net/tcp 2>/dev/null; then
    exit 0
elif grep -q "$hex_port" /proc/net/tcp6 2>/dev/null; then
    exit 0
else
    exit 1
fi
