{ settings, ... }:
{
  imports = [ ./torrent.nix ];

  systemd.tmpfiles.rules = [
    "d ${settings.media.baseDir} 0755 - ${settings.media.group} - -"
  ];

  users.groups.${settings.media.group} = { };
  users.users.bacchus.extraGroups = [ settings.media.group ];

  services.jellyfin = {
    enable = true;
    openFirewall = true;
    group = settings.media.group;
  };

  services.jellyseerr = {
    enable = true;
    openFirewall = true;
    port = settings.network.ports.jellyseerr;
  };
}
