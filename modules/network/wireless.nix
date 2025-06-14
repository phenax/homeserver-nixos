{ lib, ... }:
let
  settings = import ../../settings.nix { inherit lib; };
  wireless = settings.network.wireless;
in
{
  networking.networkmanager = {
    enable = true;
    ensureProfiles.profiles = {
      home-wifi = {
        connection = {
          id = "home-wifi";
          type = "wifi";
          autoconnect = true;
          autoconnect-priority = 10;
          autoconnect-retries = 0; # -1 (default = 4) | 0 (forever) | 1+
        };
        wifi = {
          mode = "infrastructure";
          ssid = wireless.ssid;
        };
        wifi-security = {
          auth-alg = "open";
          key-mgmt = "wpa-psk";
          psk = wireless.password;
        };
      };
    };
  };
}
