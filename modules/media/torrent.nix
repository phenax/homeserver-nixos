{ pkgs, ... }:
let
  config = import ./config.nix;
in
{
  environment.systemPackages = with pkgs; [
    tremc
  ];

  services.transmission = {
    enable = true;
    group = config.group;
    openRPCPort = true;
    settings = {
      "download-dir" = config.downloadsDir;
      "download-queue-enabled" = true;
      "download-queue-size" = 5;
      "peer-port" = 51413;
      "peer-port-random-high" = 65535;
      "peer-port-random-low" = 49152;
      "prefetch-enabled" = true;
      "rename-partial-files" = true;
      "rpc-authentication-required" = false;
      "rpc-bind-address" = "0.0.0.0";
      "rpc-enabled" = true;
      "rpc-port" = config.transmissionPort;
      "rpc-whitelist-enabled" = false;
      "script-torrent-done-enabled" = false;
      "start-added-torrents" = true;
      "trash-original-torrent-files" = false;
      "umask" = 18;
      "utp-enabled" = true;
    };
  };

  systemd.services.transmission.unitConfig = {
    RequiresMountsFor = config.mediaBaseDir;
  };
}
