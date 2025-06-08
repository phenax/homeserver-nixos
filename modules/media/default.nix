{ pkgs, ... }:
let
  config = import ./config.nix;
in
{
  systemd.tmpfiles.rules = [
    "d ${config.mediaBaseDir} 0770 - ${config.group} - -"
    "d ${config.downloadsDir} 0770 - ${config.group} - -"
    "d ${config.tvDownloads} 0770 - ${config.group} - -"
    "d ${config.moviesDownloads} 0770 - ${config.group} - -"
  ];
  users.groups."${config.group}" = { };
  users.users.bacchus.extraGroups = [ config.group ];

  services.sonarr = {
    enable = true;
    openFirewall = true;
    group = config.group;
    settings = {
      server.port = config.sonarrPort;
      auth.enabled = false;
    };
  };

  services.radarr = {
    enable = true;
    openFirewall = true;
    group = config.group;
    settings = {
      server.port = config.radarrPort;
      auth.enabled = false;
    };
  };

  services.prowlarr = {
    enable = true;
    openFirewall = true;
    settings = {
      server.port = config.prowlarrPort;
    };
  };

  services.jellyfin = {
    enable = true;
    openFirewall = true;
    group = config.group;
  };

  services.transmission = {
    enable = true;
    group = config.group;
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
      "rpc-bind-address" = "127.0.0.1";
      "rpc-enabled" = true;
      "rpc-port" = 9091;
      "rpc-whitelist-enabled" = true;
      "script-torrent-done-enabled" = false;
      "start-added-torrents" = true;
      "trash-original-torrent-files" = false;
      "umask" = 18;
      "utp-enabled" = true;
    };
  };
}
