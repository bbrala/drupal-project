#!/usr/bin/env bash

check_symlink() {
  local symlink=$1
  local target=$2

  if [ ! -d "$(dirname "$symlink")/$target" ]; then
    echo "Make "$(dirname "$symlink")/$(dirname "$target")""
    mkdir -p "$(dirname "$symlink")/$(dirname "$target")"
  fi

  if [ "$symlink" -ef "$(dirname "$symlink")/$target" ]; then
    echo "OK ($symlink -> $target)"
  elif [ -e  "$symlink" ]; then
    echo "FAIL ($symlink -> $target)"
    return 1;
  else
    ln -sf "$target" "$symlink"
    echo "FIXED ($symlink -> $target)"
  fi
}

main() {
  echo "Checking project symlinks..."
  check_symlink "app/sites/default/files" "../../../storage/files-public"
  check_symlink "web/sites/default/files" "../../../storage/files-public"
}

(
  set -euo pipefail
  main
)
