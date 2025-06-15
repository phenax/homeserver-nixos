{ settings, ... }:
{
  imports = [ ./torrent.nix ];

  systemd.tmpfiles.rules = [
    "d ${settings.media.baseDir} 0770 - ${settings.media.group} - -"
    "d ${settings.media.downloadsDir} 0770 transmission ${settings.media.group} - -"
    "d ${settings.media.tvDir} 0770 sonarr ${settings.media.group} - -"
    "d ${settings.media.moviesDir} 0770 radarr ${settings.media.group} - -"
    "d ${settings.media.musicDir} 0770 radarr ${settings.media.group} - -"
  ];
  users.groups.${settings.media.group} = { };
  users.users.bacchus.extraGroups = [ settings.media.group ];

  services.sonarr = {
    enable = true;
    openFirewall = true;
    group = settings.media.group;
    settings = {
      server.port = settings.network.ports.sonarr;
      auth.enabled = false;
    };
  };

  services.radarr = {
    enable = true;
    openFirewall = true;
    group = settings.media.group;
    settings = {
      server.port = settings.network.ports.radarr;
      auth.enabled = false;
    };
  };

  services.lidarr = {
    enable = true;
    openFirewall = true;
    group = settings.media.group;
    settings = {
      server.port = settings.network.ports.lidarr;
    };
  };

  services.prowlarr = {
    enable = true;
    openFirewall = true;
    settings = {
      server.port = settings.network.ports.prowlarr;
    };
  };

  services.jellyfin = {
    enable = true;
    openFirewall = true;
    group = settings.media.group;
  };

  services.jellyseerr = {
    enable = true;
    openFirewall = true;
    port = settings.network.ports.jellyseerr;
  };
}
