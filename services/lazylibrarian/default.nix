{ config, pkgs, lib, ... }:
with lib;
let
  lazylibrarian = pkgs.callPackage ./package.nix {};
  cfg = config.services.lazylibrarian;
in
{
  options.services.lazylibrarian = {
    enable = mkEnableOption "lazy librarian";
    # port = mkOption { type = types.int; default = 53; };
    # hosts = mkOption { type = types.attrsOf types.str; default = {}; };
  };

  environment.systemPackages = [lazylibrarian];

  config.systemd.services.lazylibrarian = mkIf cfg.enable {
    description = "Lazylibrarian";
    after = [ "network.service" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      ExecStart = "${lazylibrarian}/bin/lazylibrarian";
      Restart = "on-failure";
      RestartSec = 3;
      TimeoutSec = "5min";
      IgnoreSIGPIPE = "no";
      KillMode = "process";
      GuessMainPID = "no";
      RemainAfterExit = "yes";
    };
  };
}
