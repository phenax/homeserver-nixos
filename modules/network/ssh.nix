{ settings, ... }:
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
