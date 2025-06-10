{ lib, ... }:
let
  settings = import ../../settings.nix { inherit lib; };
  ports = settings.network.ports;
in
{
  imports = [ ./bacchus-dashboard.service.nix ];

  services.bacchus-dashboard = {
    enable = true;
    openFirewall = true;
    title = "Dashboard";
    links = [
      {
        title = "Jellyfin";
        key = "j";
        url = "http://${settings.network.host}:${toString ports.jellyfin}";
        color = "#AA5CC3";
      }
      {
        title = "Sonarr";
        key = "s";
        url = "http://${settings.network.host}:${toString ports.sonarr}";
        color = "#4c82cf";
      }
      {
        title = "Radarr";
        key = "r";
        url = "http://${settings.network.host}:${toString ports.radarr}";
        color = "#fcbd00";
      }
      {
        title = "Prowlarr";
        key = "p";
        url = "http://${settings.network.host}:${toString ports.prowlarr}";
        color = "#ff9a7e";
      }
    ];
  };
}
