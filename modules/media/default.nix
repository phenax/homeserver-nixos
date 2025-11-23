{ settings, ... }:
{
  imports = [
    ./torrent.nix
    ./servarr.nix
    ./jellyfin.nix
    ./books.nix
  ];

  systemd.tmpfiles.rules = [
    "d ${settings.media.baseDir} 0755 - ${settings.media.group} - -"
  ];

  users.groups.${settings.media.group} = { };
  users.users.bacchus.extraGroups = [ settings.media.group ];
}
