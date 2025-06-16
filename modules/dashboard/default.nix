{ settings, lib, ... }:
with lib;
let
  links = import ./links.nix { inherit settings; };
  isKeysUnique =
    let linkKeys = map (l: l.key) (filter (hasAttr "key") links);
    in length linkKeys == length (lib.unique linkKeys);
in
{
  imports = [ ../../services/bacchus-dashboard/bacchus-dashboard.service.nix ];

  assertions = [
    { assertion = isKeysUnique; message = "The dashboard link 'key' property must be unique"; }
  ];

  services.bacchus-dashboard = {
    enable = true;
    openFirewall = true;
    port = settings.network.ports.dashboard;
    title = "Bacchus Dashboard";
    embedLink = settings.grafana.dashboardEmbedLink;
    links = links;
  };
}
