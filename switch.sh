#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"
home-manager switch --flake .#pisti@devbox -b backup "$@"
