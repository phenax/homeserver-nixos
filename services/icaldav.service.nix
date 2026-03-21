{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.services.icaldavsync;
  curl = "${pkgs.curl}/bin/curl";
  updateApiUrl = "${cfg.caldavServerUrl}/${cfg.user}/${cfg.calendar}";
in
{
  options.services.icaldavsync = {
    enable = mkEnableOption "ical caldav sync";
    syncFrequency = mkOption { type = types.str; default = "*:0/30"; };
    icalLink = mkOption { type = types.str; };
    caldavServerUrl = mkOption { type = types.str; };
    user = mkOption { type = types.str; };
    password = mkOption { type = types.str; };
    calendar = mkOption { type = types.str; };
  };

  config = mkIf cfg.enable {
    systemd.user.services.icaldavsync = {
      enable = true;
      script = ''
        set -eu -o pipefail;
        ${curl} '${cfg.icalLink}' | ${curl} -X PUT '${updateApiUrl}' -u '${cfg.user}:${cfg.password}' --data-binary @-;
      '';
      serviceConfig = {
        Type = "oneshot";
      };
      startAt = cfg.syncFrequency;
    };
  };
}
