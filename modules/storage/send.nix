{ settings, ... }:
{
  services.send = {
    enable = false;
    port = settings.network.ports.send;
    host = "0.0.0.0";
    openFirewall = true;
  };
}
