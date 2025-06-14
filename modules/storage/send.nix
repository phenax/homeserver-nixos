{ lib, ... }:
let
  settings = import ../../settings.nix { inherit lib; };
in
{
  services.send = {
    enable = true;
    port = settings.network.ports.send;
    host = "0.0.0.0";
    openFirewall = true;
  };
}
