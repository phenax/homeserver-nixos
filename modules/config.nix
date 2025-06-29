{ ... }:
{
  imports = [
    ./hardware
    ./users
    ./network
    ./media
    ./dashboard
    ./storage
    ./notifications
    ./monitoring
    ./rss
    ./packages.nix
  ];

  time.timeZone = "Asia/Kolkata";
  i18n.defaultLocale = "en_GB.UTF-8";

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
    };
  };
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "25.05";
}
