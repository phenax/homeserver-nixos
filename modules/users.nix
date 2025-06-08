{ pkgs, ... }:
let
  private = import ../config.private.nix;
in {
  users.users.root.password = private.passwords.root;

  users.users.bacchus = {
    isNormalUser = true;
    shell = pkgs.bash;
    extraGroups = [
      "wheel"
      "input"
      "networkmanager"
      "git"
      "docker"
      "transmission"
      "multimedia"
    ];
  };
}
