{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
let
  cfg = config.services.omnisearch;
  omnisearch-pkg = import ./pkg.nix { inherit pkgs lib; };
in
{
  options.services.omnisearch = {
    enable = mkEnableOption "omnisearch metasearch engine";
    port = mkOption {
      type = types.int;
      default = 8087;
    };
    host = mkOption {
      type = types.str;
      default = "0.0.0.0";
    };
    openFirewall = mkOption {
      type = types.bool;
      default = false;
    };
    settings = mkOption {
      type = types.attrs;
      default = { };
    };
  };

  config = mkIf cfg.enable {
    systemd.services.omnisearch = {
      enable = true;
      script = "${omnisearch-pkg}/bin/omnisearch";
      serviceConfig = {
        Type = "simple";
        User = "omnisearch";
        Group = "omnisearch";
        WorkingDirectory = "/etc/omnisearch";
        Restart = "always";
        RestartSec = 5;
        PrivateTmp = true;
        NoNewPrivileges = true;
      };
      wantedBy = [ "multi-user.target" ];
      after = [ "network.target" ];
    };

    users.groups.omnisearch = { };
    users.users.omnisearch = {
      isSystemUser = true;
      group = "omnisearch";
      shell = null;
    };

    networking.firewall.allowedTCPPorts = mkIf cfg.openFirewall [
      cfg.port
      5000
    ];

    environment.systemPackages = [ omnisearch-pkg ];

    environment.etc = {
      "omnisearch/config.ini".text = generators.toINI { } (
        recursiveUpdate {
          server.host = "0.0.0.0";
          server.port = cfg.port;
          cache.dir = "/tmp/omnisearch_cache";
        } cfg.settings
      );
      "omnisearch/templates".source = ./templates;
      "omnisearch/static".source = ./static;
    };
  };
}
