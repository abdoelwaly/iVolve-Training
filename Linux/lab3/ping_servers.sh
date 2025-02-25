#!/bin/bash

# Loop through all possible values for x (0-255)
for x in {0..255}; do
    ip="172.25.250.$x"

    # Ping the server with a timeout of 1 second and send only 1 packet
    if ping -c 1 -W 1 "$ip" > /dev/null 2>&1; then
        echo "Server $ip is up and running"
    else
        echo "Server $ip is unreachable"
    fi
done