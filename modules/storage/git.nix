{ settings, ... }:
{
  systemd.tmpfiles.rules = [
    "d ${settings.git.baseDir} 0770 - ${settings.git.group} - -"
  ];
  users.groups.${settings.git.group} = { };
  users.users.bacchus.extraGroups = [ settings.git.group ];

  programs.git = {
    enable = true;
    config = {
      init = {
        defaultBranch = "main";
      };
      color.ui = true;
      pull.rebase = true;
      rebase.autosquash = true;
      user = {
        email = "phenax5@gmail.com";
        name = "Akshay Nair";
      };
    };
  };
}
