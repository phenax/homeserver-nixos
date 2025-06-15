{ settings, ... }:
let
  links = import ./links.nix { inherit settings; };
in
{
  imports = [ ../../services/bacchus-dashboard/bacchus-dashboard.service.nix ];

  services.bacchus-dashboard = {
    enable = true;
    openFirewall = true;
    port = settings.network.ports.dashboard;
    title = "Bacchus Dashboard";
    embedLink = settings.grafana.dashboardEmbedLink;
    links = links;
  };
}
