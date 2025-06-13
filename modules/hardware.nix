{ lib, modulesPath, ... }:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd = {
    availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "sd_mod" ];
    kernelModules = [ ];
  };
  boot.kernelModules = [
    "kvm-intel"
    "sd_mod"
  ];
  hardware = {
    enableAllFirmware = true;
    cpu.intel.updateMicrocode = true;
  };
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  # Power/power state
  powerManagement = {
    enable = true;
    cpuFreqGovernor = "powersave";
  };
  services.acpid.enable = true;
  services.logind = {
    powerKey = "ignore";
    rebootKey = "ignore";
    lidSwitch = "ignore";
    lidSwitchDocked = "ignore";
    lidSwitchExternalPower = "ignore";
    hibernateKey = "ignore";
    suspendKey = "ignore";
  };

  # Bootloader
  boot.loader = {
    systemd-boot = {
      enable = true;
      configurationLimit = 30;
    };
    timeout = 1;
    efi.canTouchEfiVariables = true;
  };

  # File system
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

  networking.useDHCP = lib.mkDefault true;

  systemd.extraConfig = ''DefaultLimitNOFILE=65536'';
  systemd.user.extraConfig = ''DefaultLimitNOFILE=65536'';
  boot.kernel.sysctl."fs.inotify.max_user_instances" = 8192;
  security.pam.loginLimits = [
    { domain = "*"; type = "-"; item = "nofile"; value = "65536"; }
  ];
}
