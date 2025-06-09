{ lib, ... }:
let
  settings = import ../../settings.nix { inherit lib; };
in
{
  services.sshd.enable = true;

  # Auth
  users.users.bacchus.openssh.authorizedKeys.keys = settings.ssh.authorizedKeys;
  services.openssh.settings = {
    PermitRootLogin = "no";
    PasswordAuthentication = false;
    ChallengeResponseAuthentication = false;
  };
}
