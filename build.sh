#!/usr/bin/env sh
set -euo pipefail

getconfig() {
  nix eval --impure --expr "(import ./settings.nix { lib = (import <nixpkgs> {}).lib; })$@" | jq -r
}

HOME_HOST="$(getconfig .network.host)"
SSH_PORT="$(getconfig .network.ports.ssh)"
SSH_TARGET="bacchus@$HOME_HOST"
SCRIPT_PATH="$(readlink -f "$0")"

run_ssh() { ssh -t "$SSH_TARGET" -p "$SSH_PORT" "$@"; }
copy() { rsync -ravh --delete --exclude '.git' -e "ssh -p $SSH_PORT" "$@"; }
waittostart() {
  echo "Waiting...";
  until timeout 2 nc -z "$HOME_HOST" "$SSH_PORT" 2> /dev/null; do
    echo -n '.';
    sleep 1
  done;
  echo -e "\nReady to connect";
}

copy_in() { copy "$1" "$SSH_TARGET:$2"; }
copy_out() { copy "$SSH_TARGET:$1" "$2"; }

config_sync() {
  copy_out '~/nixos/flake.lock' .;
  copy_in . '~/nixos';
}

rebuild() {
  run_ssh sudo nixos-rebuild switch --flake 'path:/home/bacchus/nixos#bacchus';
}

update_system() {
  run_ssh nix flake update --flake 'path:/home/bacchus/nixos';
  rebuild;
}

restart() { run_ssh sudo systemctl reboot; }

chaincmds() {
  for arg in "$@"; do
    echo "Running: $arg...";
    "$SCRIPT_PATH" "$arg";
  done
}

gen_test_dash() {
  nix eval --impure --expr 'import ./scripts/generate-test-dashboard.nix' \
  | jq -r > index.ignore.html
}
open_test_dash() { brave "file://$PWD/index.ignore.html"; }

cmd="$1"; shift;
case "$cmd" in
  sync) config_sync ;;
  run) run_ssh "$@" ;;
  build) rebuild ;;
  update) update_system ;;
  restart) restart && sleep 3 && waittostart ;;
  wait) waittostart ;;
  clean) run_ssh sudo nix-collect-garbage -d ;;
  top) run_ssh btm ;;
  fs) run_ssh lf ;;
  test-dash) gen_test_dash ;;
  open-test-dash) open_test_dash ;;
  dash) brave "http://$HOME_HOST" ;;
  copy_in) copy_in "$@" ;;
  copy_out) copy_out "$@" ;;
  _) chaincmds "$@" ;;
  *) echo "Invalid cmd: $cmd" && exit 1 ;;
esac

