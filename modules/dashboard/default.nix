{ lib, ... }:
let
  settings = import ../../settings.nix { inherit lib; };
  ports = settings.network.ports;
in
{
  imports = [ ../../services/bacchus-dashboard/bacchus-dashboard.service.nix ];

  services.bacchus-dashboard = {
    enable = true;
    openFirewall = true;
    port = ports.dashboard;
    title = "Bacchus Dashboard";
    embedLink = settings.grafana.dashboardEmbedLink;
    links = [
      {
        title = "Jellyfin";
        key = "j";
        url = "http://jellyfin.local";
        altUrl = "http://${settings.network.host}:${toString ports.jellyfin}";
        color = "#AA5CC3";
      }
      {
        title = "Jellyseer";
        key = "l";
        url = "http://jellyseerr.local";
        altUrl = "http://${settings.network.host}:${toString ports.jellyseerr}";
        color = "#5345e6";
      }
      {
        title = "Radarr";
        key = "r";
        url = "http://radarr.local";
        altUrl = "http://${settings.network.host}:${toString ports.radarr}";
        color = "#fcbd00";
      }
      {
        title = "Sonarr";
        key = "s";
        url = "http://sonarr.local";
        altUrl = "http://${settings.network.host}:${toString ports.sonarr}";
        color = "#4c82cf";
      }
      {
        title = "Prowlarr";
        key = "p";
        url = "http://prowlarr.local";
        altUrl = "http://${settings.network.host}:${toString ports.prowlarr}";
        color = "#ff9a7e";
      }
      {
        title = "Syncthing";
        key = "y";
        url = "http://syncthing.local";
        altUrl = "http://${settings.network.host}:${toString ports.syncthing}";
        color = "#0891d1";
      }
      {
        title = "Ntfy-sh";
        key = "n";
        url = "http://ntfy.local";
        altUrl = "http://${settings.network.host}:${toString ports.ntfy}";
        color = "#2dc9b5";
      }
      {
        title = "Grafana";
        key = "g";
        url = "http://grafana.local";
        altUrl = "http://${settings.network.host}:${toString ports.grafana}";
        color = "#f05a28";
      }
      {
        title = "Send";
        key = "f";
        url = "http://send.local";
        altUrl = "http://${settings.network.host}:${toString ports.send}";
        color = "#AA5CC3";
      }
    ];
  };
}
