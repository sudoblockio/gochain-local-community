#!/bin/bash

# Target port
port=9080
# Timeout in seconds (2 minutes)
timeout=120
# Start time
start_time=$(date +%s)

while true; do
    # Check current time
    current_time=$(date +%s)
    # Calculate elapsed time
    elapsed=$(( current_time - start_time ))

    # Check if timeout has been reached
    if [ $elapsed -ge $timeout ]; then
        echo "Timeout reached. Exiting."
        exit 1
    fi

    # Check if port 9080 is available using netcat
    nc -z localhost $port
    if [ $? -eq 0 ]; then
        echo "Port $port is available."
        sleep 5
        exit 0
    else
        echo "Port $port is not available yet. Retrying..."
    fi

    # Wait for a short period before retrying
    sleep 2
done
