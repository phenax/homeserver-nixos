{ pkgs, settings, phenax-yayarr, ... }@attrs:
let
  ports = settings.network.ports;
  yarr = settings.yarr;
  utils = import ./utils.nix attrs;

  yarrSetupScript = utils.createYarrSetupScript {
    inherit (yarr) username api_key;
    api_url = "http://localhost:${toString ports.yarr}";
    feeds = import ./feeds.nix;
    settings = {
      theme_font = "monospace";
      theme_name = "night";
      theme_size = 1.1;
      refresh_rate = 30;
    };
  };
in
{
  services.yarr = {
    enable = true;
    port = ports.yarr;
    address = "0.0.0.0";
    package = phenax-yayarr;
    authFilePath = pkgs.writeText "yarr-auth" ''${yarr.username}:${yarr.password}'';
  };

  networking.firewall.allowedTCPPorts = [ ports.yarr ];

  environment.systemPackages = [ yarrSetupScript ];
}
