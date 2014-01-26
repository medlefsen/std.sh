#!/bin/false

use args

function command-exists? {
  command -v "$@" &> /dev/null
  return "$?"
}

file-lock() {
  @args fd
  flock "$fd"
}

file-unlock() {
  @args fd
  flock -u "$fd"
}
