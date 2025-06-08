# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
    ./modules/hardware.nix
    ./modules/users.nix
    ./modules/network/default.nix
    ./modules/media/default.nix
  ];

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    bottom
    mtm
    neovim
    lf
    util-linux
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
