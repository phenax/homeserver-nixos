{ lib, ... }:
let
  private = import ../../config.private.nix;
in {
  services.sshd.enable = true;

  # Auth
  # TODO: dont allow via password
  # openssh.authorizedKeys.keys = private.ssh.authorizedKeys;
  services.openssh.settings.PermitRootLogin = "yes"; 
}
