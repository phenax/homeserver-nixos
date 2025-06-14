{ lib, config, ... }:
with lib;
let
  cfg = config.services.bacchus-dns;
in
{
  options.services.bacchus-dns = {
    enable = mkEnableOption "dns server mappings";
    port = mkOption { type = types.int; default = 53; };
    openFirewall = mkEnableOption "open required ports in firewall";
    ttl = mkOption { type = types.int; default = 3600; };
    fallback = mkOption { type = types.listOf types.str; default = [ "1.1.1.1" ]; };
    hosts = mkOption { type = types.attrsOf types.str; default = {}; };
  };

  config = {
    services.coredns = mkIf cfg.enable {
      enable = true;
      extraArgs = [ "-dns.port=${toString cfg.port}" ];
      config = ''
      . {
        hosts {
          ${concatStringsSep "\n" (
            mapAttrsToList (domain: target: "${target} ${domain}") cfg.hosts)}
          fallthrough
        }
        forward . ${concatStringsSep " " cfg.fallback}
        cache ${toString cfg.ttl}
        errors
      }
      '';
    };

    networking.firewall = mkIf cfg.openFirewall {
      allowedTCPPorts = [ cfg.port ];
      allowedUDPPorts = [ cfg.port ];
    };
  };
}
