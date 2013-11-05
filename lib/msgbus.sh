#!/bin/false

use args
use sys

msgbus-daemon() {
  # Try to pick files that are unique and always around.
  # On systems with /proc, us that, otherwise use temp files
  if [ -f "/proc/$$" ]
  then
    local rlock="/proc/$$"
  else
    local rlock=`mktemp`
  fi
  if [ -f "/proc/$$/cmdline" ]
  then
    local rlock="/proc/$$/cmdline"
  else
    local rlock=`mktemp`
  fi
  local wlock=`mktemp`
  trap -- "rm -f '$rlock' '$wlock'" EXIT
  
  msgbus-format-msg "$rlock"
  msgbus-format-msg "$wlock"
  cat
}

msgbus-init() {
  if [ -z "$_lib_sh_MSGBUS_PID" ]
  then
    coproc msgbus-daemon

    exec {_lib_sh_MSGBUS_IN}>&${COPROC[1]}
    eval "exec ${COPROC[1]}>&-"
    exec {_lib_sh_MSGBUS_OUT}<&${COPROC[0]}
    eval "exec ${COPROC[0]}<&-"
    _lib_sh_MSGBUS_PID="$COPROC_PID"
    _lib_sh_MSGBUS_RLOCK="$(msgbus-parse-msg <&$_lib_sh_MSGBUS_OUT)"
    _lib_sh_MSGBUS_WLOCK="$(msgbus-parse-msg <&$_lib_sh_MSGBUS_OUT)"

    unset COPROC
  fi
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
  @args msg
  msgbus-init
  (
    file-lock 22
    msgbus-format-msg "$msg" >&$_lib_sh_MSGBUS_IN
  ) 22<$_lib_sh_MSGBUS_WLOCK
}

msgbus-recv() {
  msgbus-init
  (
    file-lock 22
    msgbus-parse-msg <&$_lib_sh_MSGBUS_OUT
  ) 22<$_lib_sh_MSGBUS_RLOCK
}

msgbus-init

