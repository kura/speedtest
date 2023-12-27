#!/bin/bash
THREADS="${THREADS:-32}"  # overwrite with env

/speedtest-go --json -t $THREADS | jq
