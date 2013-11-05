#!/bin/bash

eval `lib.sh`

use msgbus

val="$(echo "hi"; msgbus-send "hello world")"

echo "$val=hi"
msg="$(msgbus-recv)"
echo "$msg=hello world"


PIDS=()
msgbus-send "hello world" &
PIDS+=("$!")
echo "$(msgbus-recv)" &
PIDS+=("$!")
msgbus-send "hello world" &
PIDS+=("$!")
msgbus-send "hello world" &
PIDS+=("$!")
echo "$(msgbus-recv)" &
PIDS+=("$!")
echo "$(msgbus-recv)" &
PIDS+=("$!")

for PID in "${PIDS[@]}"
do
  wait "$PID"
done

