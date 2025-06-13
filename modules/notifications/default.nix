{ lib, pkgs, ... }:
let
  settings = import ../../settings.nix { inherit lib; };
  host = settings.network.host;
  ports = settings.network.ports;
  url = "http://${host}:${toString ports.ntfy}";
in
{
  networking.firewall.allowedTCPPorts = [ ports.ntfy ];

  services.ntfy-sh = {
    enable = true;
    settings = {
      listen-http = ":${toString ports.ntfy}";
      base-url = url;
    };
  };

  environment.systemPackages = [
    (pkgs.writeShellScriptBin "push-ntfy" ''
      set -eu;
      topic="$1"; shift 1;
      body="$1"; shift 1;
      ${pkgs.ntfy-sh}/bin/ntfy pub "$@" "${url}/$topic" "$body"
    '')
  ];
}
