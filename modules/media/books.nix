{ settings, pkgs, ... }:
{
  # NOTE: Run `head -c 64 /dev/urandom | base64 --wrap=0 > /var/lib/kavita-token`
  services.kavita = {
    enable = true;
    tokenKeyFile = "/var/lib/kavita-token";
    user = "kavita"; # TODO: fix permissions
    settings = {
      Port = settings.network.ports.library;
    };
  };

  networking.firewall.allowedTCPPorts = [settings.network.ports.library];
}
