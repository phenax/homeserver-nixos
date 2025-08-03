{ settings, ... }:
{
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
