{ config, lib, ... }:
with lib;
let
  cfg = config.services.service-router;
in {
  imports = [
    ./bacchus-dns.service.nix
  ];

  options.services.service-router = {
    enable = mkEnableOption "enable router";
    routes = mkOption {
      type = types.attrsOf (types.submodule { options = {
        port = mkOption { type = types.int; };
        host = mkOption { type = types.str; default = "127.0.0.1"; };
        protocol = mkOption { type = types.str; default = "http"; };
        basePath = mkOption { type = types.str; default = ""; };
        extraNginxOptions = mkOption { type = types.attrs; default = {}; };
      }; });
      default = {};
    };
  };

  config = lib.mkIf cfg.enable {
    services.nginx = {
      enable = true;
      recommendedOptimisation = true;
      virtualHosts = lib.mapAttrs (_: val:
        let
          opts = if hasAttr "extraNginxOptions" val then val.extraNginxOptions else {};
        in {
          locations."/" = {
            proxyPass =
              "${val.protocol}://${val.host}:${toString val.port}${val.basePath}";
            proxyWebsockets = true;
          } // opts;
        }
      ) cfg.routes;
    };

    # Hostname mapping
    services.bacchus-dns = {
      enable = true;
      hosts = mapAttrs (_: val: val.host) cfg.routes;
    };
  };
}
