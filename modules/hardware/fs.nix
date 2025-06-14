{ ... }:
{
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/nixos";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-label/boot";
      fsType = "vfat";
    };
    "/media" = {
      device = "/dev/disk/by-label/media";
      fsType = "ext4";
      options = [ "rw" "nofail" "x-systemd.automount" "x-systemd.mount-timeout=30s" ];
    };
  };
  swapDevices = [{ device = "/dev/disk/by-label/swap"; }];

  # Set high limits for file watching/file handles
  systemd.extraConfig = ''DefaultLimitNOFILE=65536'';
  systemd.user.extraConfig = ''DefaultLimitNOFILE=65536'';
  boot.kernel.sysctl."fs.inotify.max_user_instances" = 8192;
  security.pam.loginLimits = [
    { domain = "*"; type = "-"; item = "nofile"; value = "65536"; }
  ];
}
