{ lib, ... }:
let
  settings = import ../../settings.nix { inherit lib; };
  ports = settings.network.ports;
  host = settings.network.host;
in
{
  imports = [
    ./wireless.nix
    ./ssh.nix
    ./service-router.service.nix
  ];

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
      "grafana.local" = { inherit host; port = ports.grafana; extraOptions.recommendedProxySettings = true; };
    };
  };

  networking = {
    hostName = "bacchus";
    firewall.enable = true;
  };
}
