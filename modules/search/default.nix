{ settings, ... }:
{
  imports = [ ../../services/omnisearch ];

  services.omnisearch = {
    enable = true;
    port = settings.network.ports.search;
    openFirewall = true;
    settings = {
      server.domain = "http://search.local";
    };
  };
}
