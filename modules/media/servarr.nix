{ settings, ... }:
{
  systemd.tmpfiles.rules = [
    "d ${settings.media.tvDir} 0770 sonarr ${settings.media.group} - -"
    "d ${settings.media.moviesDir} 0770 radarr ${settings.media.group} - -"
    "d ${settings.media.musicDir} 0770 lidarr ${settings.media.group} - -"
  ];

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
}
