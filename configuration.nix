{ pkgs, ... }:
{
  imports = [
    ./modules/hardware
    ./modules/users
    ./modules/network
    ./modules/media
    ./modules/dashboard
    ./modules/storage
    ./modules/notifications
    ./modules/monitoring
  ];

  # services.shiori = {
  #   enable = true;
  #   port = 3144;
  # };
  # networking.firewall.allowedTCPPorts = [ 3144 ];

  environment.systemPackages = with pkgs; [
    bottom
    mtm
    neovim
    lf
    util-linux
    dig
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
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "25.05";
}
