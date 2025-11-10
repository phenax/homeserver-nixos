{ settings, ... }:
let
  ports = settings.network.ports;
  host = settings.network.host;
in
{
  imports = [
    ./wireless.nix
    ./ssh.nix
    ../../services/service-router.service.nix
    ../../services/bacchus-dns.service.nix
  ];

  networking = {
    hostName = "bacchus";
    firewall.enable = true;
  };

  services.service-router = {
    enable = true;
    routes = {
      "home.local" = { inherit host; port = ports.dashboard; };
      "sonarr.local" = { inherit host; port = ports.sonarr; };
      "radarr.local" = { inherit host; port = ports.radarr; };
      "prowlarr.local" = { inherit host; port = ports.prowlarr; };
      "jellyfin.local" = { inherit host; port = ports.jellyfin; };
      "jellyseerr.local" = { inherit host; port = ports.jellyseerr; };
      "syncthing.local" = { inherit host; port = ports.syncthing; };
      "lidarr.local" = { inherit host; port = ports.lidarr; };
      "ntfy.local" = { inherit host; port = ports.ntfy; };
      "grafana.local" = { inherit host; port = ports.grafana; extraNginxOptions.recommendedProxySettings = true; };
      # "send.local" = { inherit host; port = ports.send; };
      "photos.local" = { inherit host; port = ports.immich; };
      "news.local" = { inherit host; port = ports.yarr; };
      "librarian.local" = { inherit host; port = ports.lazylibrarian; };
    };
  };

  # Host mappings defined by service-router
  services.bacchus-dns = {
    enable = true;
    port = 53;
    openFirewall = true;
    fallback = [ "1.1.1.1" "8.8.8.8" ];
  };
}
