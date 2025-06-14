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
