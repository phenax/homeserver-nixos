{ lib, pkgs, modulesPath, ... }:
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
  powerManagement = {
    enable = true;
    cpuFreqGovernor = "powersave";
  };
}
