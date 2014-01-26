#!/bin/bash

eval `lib.sh`

use msgbus

@msgbus bus

val="$(echo "hi"; msgbus-send "$bus" "hello world")"

echo "$val=hi"
msg="$(msgbus-recv "$bus")"
echo "$msg=hello world"


PIDS=()
msgbus-send "$bus" "hello world" &
PIDS+=("$!")
echo "$(msgbus-recv "$bus")" &
PIDS+=("$!")
msgbus-send "$bus" "hello world" &
PIDS+=("$!")
msgbus-send "$bus" "hello world" &
PIDS+=("$!")
echo "$(msgbus-recv "$bus")" &
PIDS+=("$!")
echo "$(msgbus-recv "$bus")" &
PIDS+=("$!")

for PID in "${PIDS[@]}"
do
  wait "$PID"
done

