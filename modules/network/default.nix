{ lib, ... }:
let
  settings = import ../../settings.nix { inherit lib; };
in
{
  imports = [ ./ssh.nix ];

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
