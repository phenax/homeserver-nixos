#!/usr/bin/env sh
set -euo pipefail

SSH_TARGET="bacchus@192.168.0.117"

config_sync() {
  rsync -r "$SSH_TARGET:~/nixos/flake.lock" .
  rsync -r . "$SSH_TARGET:~/nixos"
  # ssh "$SSH_TARGET" sh -c "nixos-rebuild build --flake 'path:/home/bacchus/nixos#bacchus'"
}

run_ssh() { ssh "$SSH_TARGET" "$@"; }

cmd="$1"; shift;
case "$cmd" in
  sync) config_sync ;;
  run) run_ssh "$@" ;;
  *) echo "foo" && exit 1 ;;
esac

