#!/usr/bin/env sh
set -euo pipefail

getconfig() {
  nix eval --impure --expr "(import ./config.private.nix)$@" | jq -r
}

SSH_HOST="$(getconfig .ssh.host)"
SSH_PORT="$(getconfig .ssh.port)"
SSH_TARGET="bacchus@$SSH_HOST"
SCRIPT_PATH="$(readlink -f "$0")"

run_ssh() { ssh -t "$SSH_TARGET" -p "$SSH_PORT" "$@"; }
copy() { rsync -r -e "ssh -p $SSH_PORT" "$@"; }
waittostart() {
  echo "Waiting...";
  until timeout 2 nc -z "$SSH_HOST" "$SSH_PORT" 2> /dev/null; do
    echo -n '.';
    sleep 2
  done;
  echo -e "\nReady to connect";
}

config_sync() {
  copy "$SSH_TARGET:~/nixos/flake.lock" .;
  copy . "$SSH_TARGET:~/nixos";
}

rebuild() {
  run_ssh sudo nixos-rebuild switch --flake 'path:/home/bacchus/nixos#bacchus';
}

restart() { run_ssh sudo systemctl reboot; }

chaincmds() {
  for arg in "$@"; do
    echo "Running: $arg...";
    "$SCRIPT_PATH" "$arg";
  done
}

cmd="$1"; shift;
case "$cmd" in
  sync) config_sync ;;
  run) run_ssh "$@" ;;
  build) rebuild ;;
  restart) restart && sleep 3 && waittostart ;;
  wait) waittostart ;;
  clean) run_ssh sudo nix-collect-garbage -d ;;
  _) chaincmds "$@" ;;
  *) echo "Invalid cmd: $1" && exit 1 ;;
esac

