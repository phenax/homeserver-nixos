{ pkgs, settings, ... }:
{
  users.users.root.password = settings.passwords.root;

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
