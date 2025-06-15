let
  nixpkgs = import <nixpkgs> {};
  settings = import ../settings.nix { inherit (nixpkgs) lib; };
  links = import ../modules/dashboard/links.nix { inherit settings; };
in
import ../services/bacchus-dashboard/dashboard-template.nix {
  title = "Dashboard";
  embedLink = settings.grafana.dashboardEmbedLink;
  inherit links;
}
