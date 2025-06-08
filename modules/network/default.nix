{ ... }:
let
  private = import ../../config.private.nix;
in {
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
            ssid = private.wireless.ssid;
          };
          wifi-security = {
            auth-alg = "open";
            key-mgmt = "wpa-psk";
            psk = private.wireless.password;
          };
        };
      };
    };
  };
}
