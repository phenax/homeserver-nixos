#!/usr/bin/env sh
set -euo pipefail

SSH_TARGET="bacchus@192.168.0.117"

config_sync() {
  sshpass -p password rsync -r "$SSH_TARGET:~/nixos/flake.lock" .
  sshpass -p password rsync -r . "$SSH_TARGET:~/nixos"
  # sshpass -p password ssh "$SSH_TARGET" sh -c "nixos-rebuild build --flake 'path:/home/bacchus/nixos#bacchus'"
}

cmd="$1"; shift;
case "$cmd" in
  sync) config_sync ;;
  *) echo "foo" && exit 1 ;;
esac

