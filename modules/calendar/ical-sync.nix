{ settings, ... }:
{
  imports = [ ../../services/icaldav.service.nix ];

  services.icaldavsync = {
    enable = true;
    syncFrequency = "*:0/30";
    icalLink = settings.calendar.icalLink;
    caldavServerUrl = "http://127.0.0.1:${toString settings.network.ports.caldav}";
    password = "pass";
    user = "joe";
    calendar = "Work";
  };
}
