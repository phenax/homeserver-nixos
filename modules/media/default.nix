{ ... }:
let
  config = import ./config.nix;
in
{
  imports = [ ./torrent.nix ];

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
}
