{ lib, ... }:
let
  settings = import ../../settings.nix { inherit lib; };
  ports = settings.network.ports;
  host = settings.network.host;
in
{
  imports = [
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
      "syncthing.local" = { inherit host; port = ports.syncthing; };
      "lidarr.local" = { inherit host; port = ports.lidarr; };
    };
  };

  networking = {
    hostName = "bacchus";

    firewall.enable = true;

    networkmanager = {
      enable = true;
      # wifi.powersave = true;
      ensureProfiles.profiles = {
        home-wifi = {
          connection = {
            id = "home-wifi";
            type = "wifi";
            autoconnect = true;
          };
          wifi = {
            mode = "infrastructure";
            ssid = settings.network.wireless.ssid;
          };
          wifi-security = {
            auth-alg = "open";
            key-mgmt = "wpa-psk";
            psk = settings.network.wireless.password;
          };
        };
      };
    };
  };
}
