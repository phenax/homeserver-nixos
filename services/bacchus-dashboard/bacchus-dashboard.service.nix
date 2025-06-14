{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.services.bacchus-dashboard;

  rootHTML = import ./dashboard-template.nix cfg;
  indexHTMLFile = pkgs.writeText "index.html" rootHTML;

  pageDir = pkgs.stdenv.mkDerivation {
    pname = "dashboard-page";
    version = "0.0.0";
    unpackPhase = "true"; # no source
    installPhase = ''
      mkdir -p $out;
      cp ${indexHTMLFile} $out/index.html;
    '';
  };
in
{
  options.services.bacchus-dashboard = {
    enable = mkEnableOption "Enable dashboard";
    title = mkOption { type = types.str; default = "Dashboard"; };
    links = mkOption {
      type = types.listOf (types.attrs);
      default = [];
    };
    embedLink = mkOption { type = types.str; };
    openFirewall = mkEnableOption "Open firewall ports";
    host = mkOption { type = types.str; default = "_"; };
    port = mkOption { type = types.int; default = 80; };
  };

  config = {
    services.nginx = mkIf cfg.enable {
      enable = true;
      virtualHosts.${cfg.host} = {
        listen = [ { addr = toString cfg.port; } ];
        locations."/" = {
          root = pageDir;
          tryFiles = "$uri /index.html";
        };
      };
    };

    networking.firewall.allowedTCPPorts = mkIf cfg.openFirewall [ 80 ];
  };
}
