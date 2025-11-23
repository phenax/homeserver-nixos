{ settings, lib, ... }:
let
  group = settings.syncthing.group;
in
{
  systemd.tmpfiles.rules = [
    "d ${settings.syncthing.baseDir} 0770 - ${group} - -"
    "d ${settings.syncthing.photosDir} 0770 - ${group} - -"
  ];
  users.groups.${group} = { };
  users.users.bacchus.extraGroups = [ group ];

  networking.firewall.allowedTCPPorts = [ settings.network.ports.syncthing ];

  services.syncthing = {
    enable = true;
    user = "bacchus";
    group = group;
    dataDir = settings.syncthing.baseDir;
    guiAddress = "0.0.0.0:${toString settings.network.ports.syncthing}";
    overrideFolders = true;

    settings = {
      folders = {
        artemis-photos = {
          label = "Photos";
          path = settings.syncthing.photosDir;
          devices = lib.attrNames settings.syncthing.devices;
        };
        artemis-books = {
          label = "Books";
          path = settings.media.booksDir;
          devices = lib.attrNames settings.syncthing.devices;
        };
        artemis-docs = {
          label = "Documents";
          path = settings.paperless.docsDir;
          devices = lib.attrNames settings.syncthing.devices;
        };
      };

      overrideDevices = false;
      overrideFolders = false;
      devices = settings.syncthing.devices;

      options.urAccepted = -1;

      extraOptions = {
        gui = {
          enabled = true;
          theme = "black";
          user = settings.syncthing.username;
          password = settings.syncthing.password;
        };
      };
    };
  };
}
