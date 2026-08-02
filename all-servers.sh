#!/bin/bash

BlazeServer &
PID1=$!

gw2-server "$@" &
PID2=$!

trap "kill "$PID1" "$PID2" > /dev/null; exit" INT TERM

wait "$PID1" "$PID2"
