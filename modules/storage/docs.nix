{ settings, lib, ... }:
{
  services.paperless = {
    enable = true;
    user = settings.paperless.user;
    address = "0.0.0.0";
    database.createLocally = true;
    port = settings.network.ports.paperless;
    consumptionDir = settings.paperless.docsDir;
    consumptionDirIsPublic = true;
    settings = {
      PAPERLESS_URL = lib.mkForce "http://paperless.local";
    };
  };
}
