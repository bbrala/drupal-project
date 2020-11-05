#!/usr/bin/env bash

main() {
  echo "Running post update commands..."

  bash scripts/sh/check-symlinks.sh
  bash scripts/sh/publish-assets.sh

  echo "Done"
}

(
  set -euo pipefail
  main
)
