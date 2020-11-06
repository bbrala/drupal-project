#!/usr/bin/env bash

sync_assets() {
  local src=$1
  local dst=$2

  echo "Syncing ${src} with ${dst}..."

  # Only display progress when stdout is opened on a terminal.
  local info="stats2"
  if [ -t 1 ] ; then
    info="progress2,stats2"
  fi

  rsync --info="$info" --archive --recursive --delete --delete-excluded --prune-empty-dirs --whole-file \
    --exclude='*_demo/' \
    --exclude='demo_*/' \
    --exclude='testing/' \
    --exclude='testing_*/' \
    --exclude='tests/' \
    --exclude='scripts/' \
    --exclude='simpletest/' \
    --exclude='*.es6.js' \
    --include='*.'{js,css,map,svg,png,jpg,gif,eot,ttf,woff,woff2,otf} \
    --include='*/' \
    --exclude='*' \
    "$src" "$dst"
}

main() {
  local dirs="core modules profiles themes"

  echo "Publishing assets of project dependencies..."

  for dir in $dirs; do
    if [ ! -d "app/${dir}/" ]; then
      rm -rf "web/${dir}/"
      continue
    fi

    if [ ! -e "web/${dir}/" ]; then
      mkdir -p "web/${dir}/"
    fi

    sync_assets "app/${dir}/" "web/${dir}/"
  done

  cp "scripts/template-files/install.php" "web/core/install.php"
}

(
  set -euo pipefail
  main
)
