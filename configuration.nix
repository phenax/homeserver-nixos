# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, lib, ... }:
let
  settings = import ./settings.nix { inherit lib; };
  ports = settings.network.ports;
  host = settings.network.host;
in
{
  imports = [
    ./modules/hardware.nix
    ./modules/users.nix
    ./modules/network
    ./modules/media
    ./modules/dashboard
    ./modules/service-router.service.nix
  ];

  services.service-router = {
    enable = true;
    routes = {
      "home.local" = { inherit host; port = ports.dashboard; };
      "sonarr.local" = { inherit host; port = ports.sonarr; };
      "radarr.local" = { inherit host; port = ports.radarr; };
      "prowlarr.local" = { inherit host; port = ports.prowlarr; };
      "jellyfin.local" = { inherit host; port = ports.jellyfin; };
    };
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    bottom
    mtm
    neovim
    lf
    util-linux
    dig
  ];

  systemd.extraConfig = ''DefaultLimitNOFILE=65536'';
  systemd.user.extraConfig = ''DefaultLimitNOFILE=65536'';
  boot.kernel.sysctl."fs.inotify.max_user_instances" = 8192;
  security.pam.loginLimits = [
    { domain = "*"; type = "-"; item = "nofile"; value = "65536"; }
  ];

  time.timeZone = "Asia/Kolkata";
  i18n.defaultLocale = "en_GB.UTF-8";

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
  };
  nix.gc = {
    automatic = true;
    dates = "weekly";
  };

  system.stateVersion = "25.05";
}
