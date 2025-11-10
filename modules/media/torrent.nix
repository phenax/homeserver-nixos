{ pkgs, settings, ... }:
{
  systemd.tmpfiles.rules = [
    "d ${settings.media.downloadsDir} 0770 transmission ${settings.media.group} - -"
  ];

  environment.systemPackages = with pkgs; [
    tremc
  ];

  services.transmission = {
    enable = true;
    group = settings.media.group;
    package = pkgs.transmission_4;
    openRPCPort = true;
    settings = {
      "download-dir" = settings.media.downloadsDir;
      "download-queue-enabled" = true;
      "download-queue-size" = 5;
      "peer-port" = 51413;
      "peer-port-random-high" = 65535;
      "peer-port-random-low" = 49152;
      "prefetch-enabled" = true;
      "rename-partial-files" = true;
      "rpc-authentication-required" = false;
      "rpc-bind-address" = if settings.network.exposeTransmissionRPC then "0.0.0.0" else "127.0.0.1";
      "rpc-enabled" = true;
      "rpc-port" = settings.network.ports.transmissionRPC;
      "rpc-whitelist-enabled" = false;
      "script-torrent-done-enabled" = false;
      "start-added-torrents" = true;
      "trash-original-torrent-files" = false;
      "umask" = 18;
      "utp-enabled" = true;
    };
  };

  systemd.services.transmission.unitConfig = {
    RequiresMountsFor = settings.media.baseDir;
  };
}
