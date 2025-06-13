{ config, lib, dns, ... }:
with lib;
let
  cfg = config.services.service-router;
  domainAZone = domain: record: {
    A = [ record ];
    SOA = {
      nameServer = "ns.${domain}.";
      adminEmail = "dont@email.me";
      serial = 2019030800;
    };
    NS = [ "ns.${domain}." ];
  };
in {
  options.services.service-router = {
    enable = mkEnableOption "enable router";
    routes = mkOption {
      type = types.attrsOf (types.submodule { options = {
        port = mkOption { type = types.int; };
        host = mkOption { type = types.str; default = "127.0.0.1"; };
        protocol = mkOption { type = types.str; default = "http"; };
        nginx = mkOption { type = types.attrs; default = {}; };
      }; });
      default = {};
    };
  };

  config = lib.mkIf cfg.enable {
    services.nginx = {
      enable = true;
      recommendedOptimisation = true;
      virtualHosts = lib.mapAttrs (_: val: {
        locations."/" = if val.nginx == {} then {
          proxyPass = "${val.protocol}://${val.host}:${toString val.port}";
          proxyWebsockets = true;
        } else val.nginx;
      }) cfg.routes;
    };

    services.nsd = {
      enable = true;
      interfaces = [ "0.0.0.0" ];
      zones = lib.mapAttrs (domain: val: {
        data = dns.lib.toString domain (domainAZone domain val.host);
      }) cfg.routes;
    };
    networking.firewall.allowedTCPPorts = [ 53 ];
    networking.firewall.allowedUDPPorts = [ 53 ];

    networking.hosts."127.0.0.1" = lib.mapAttrsToList (name: _: name) cfg.routes;
  };
}
