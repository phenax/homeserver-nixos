{ lib, ... }:
let
  private = import ../../config.private.nix;
in {
  services.sshd.enable = true;

  # Auth
  users.users.bacchus.openssh.authorizedKeys.keys = private.ssh.authorizedKeys;
  services.openssh.settings = {
    PermitRootLogin = "no";
    PasswordAuthentication = false;
    ChallengeResponseAuthentication = false;
  };
}
