{ settings, ... }:
let
  ports = settings.network.ports;
in
{
  systemd.tmpfiles.rules = [
    "d ${settings.immich.baseDir} 0770 ${settings.immich.user} ${settings.immich.group} - -"
  ];

  services.immich = {
    enable = true;
    host = "0.0.0.0";
    port = ports.immich;
    group = settings.immich.group;
    user = settings.immich.user;
    openFirewall = true;
    mediaLocation = settings.immich.baseDir;
    machine-learning.enable = false;
    settings = {
      library.watch.enabled = true;
      library.scan = {
        enabled = true;
        cron = "0 */5 * * *";
      };
      trash = {
        enabled = true;
        days = 15;
      };
      backup.database = {
        enabled = false;
        cronExpression = "0 02 * * *";
      };
      server.externalDomain = "http://photos.local";
      passwordLogin.enabled = true;
      newVersionCheck.enabled = false;
      map.enabled = false;
      machineLearning.enabled = false;
    };
  };

  users.users.bacchus.extraGroups = [ settings.immich.group ];
  users.users.${settings.immich.user}.extraGroups = [
    settings.immich.group
    settings.syncthing.group
    settings.media.group
  ];
}
