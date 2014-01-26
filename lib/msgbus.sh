#!/bin/false

use args
use sys
use macro

msgbus() {
  @args varname
  echo 'declare -a '"$varname;"
  echo "$varname"'[1]="$(mktemp -u)"; mkfifo "${'"$varname"'[1]}";'
  echo "$varname"'[2]="$(mktemp)";'
  echo 'exec {'"$varname"'}<>"${'"$varname"'[1]}";'
  echo 'rm "${'"$varname"'[1]}";'
  echo "$varname"'[1]="${'"$varname"'}";'
  echo 'exec {'"$varname"'}<>"${'"$varname"'[2]}";'
  echo 'rm "${'"$varname"'[2]}";'
  echo "$varname"'[2]="${'"$varname"'}";'
  echo "$varname"'="${'"$varname"'[1]}:${'"$varname"'[2]}";'
}
macroify msgbus

msgbus-destroy() {
  @args msgbus
  local bus="${msgbus%:*}" readlock="${msgbus#*:}"
  exec {bus}<&-  
  exec {readlock}<&-  
}

msgbus-format-msg() {
  @args msg
  echo "${#msg}"
  echo -n "$msg"
}

msgbus-parse-msg() {
  read length
  read -N "$length" msg
  echo -n $msg
}

msgbus-send() {
  @args msgbus msgs...
  local bus="${msgbus%:*}"
  for msg in "${msgs[@]}"
  do
    file-lock "$bus"
    msgbus-format-msg "$msg" >&"$bus"
    file-unlock "$bus"
  done
}

msgbus-recv() {
  @args msgbus
  local bus="${msgbus%:*}" readlock="${msgbus#*:}"
  file-lock "$readlock"
  msgbus-parse-msg <&"$bus"
  file-unlock "$readlock"
}
