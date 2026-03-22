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

  # Service mappings (dns + nginx)
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
      # "lidarr.local" = { inherit host; port = ports.lidarr; };
      "ntfy.local" = { inherit host; port = ports.ntfy; };
      "send.local" = { inherit host; port = ports.send; };
      "photos.local" = { inherit host; port = ports.immich; };
      "news.local" = { inherit host; port = ports.yarr; };
      "paperless.local" = { inherit host; port = ports.paperless; configureNginx = true; };
      "calendar.local" = { inherit host; port = ports.caldav; };
      "search.local" = { inherit host; port = ports.search; };
      "library.local" = { inherit host; port = ports.library; };
    };
  };

  # DNS-only mappings
  services.bacchus-dns.hosts = {
    "smartfridge.local" = settings.network.smartfridgeIP;
  };

  # Host mappings defined by service-router
  services.bacchus-dns = {
    enable = true;
    port = 53;
    openFirewall = true;
    fallback = [ "1.1.1.1" "8.8.8.8" ];
  };
}
