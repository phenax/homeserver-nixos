{ settings, ... }:
let
  radicaleDir = "/var/lib/radicale/collections";
  radicalePort = settings.network.ports.caldav;
in
{
  systemd.tmpfiles.rules = [
    "d ${radicaleDir} 0755 - radicale - -"
  ];

  services.radicale = {
    enable = true;
    settings = {
      server = {
        hosts = [
          "0.0.0.0:${toString radicalePort}"
          "[::]:${toString radicalePort}"
        ];
      };
      auth = {
        type = "none";
      };
      web = {
        type = "internal";
      };
      storage = {
        filesystem_folder = radicaleDir;
      };
    };
  };
}
