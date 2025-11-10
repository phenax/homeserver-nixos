{ lib, nixos-hardware, modulesPath, ... }:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    "${nixos-hardware}/lenovo/ideapad"
    ./fs.nix
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
  services.logind.settings.Login = {
    HandlePowerKey = "ignore";
    HandleRebootKey = "ignore";
    HandleLidSwitch = "ignore";
    HandleLidSwitchDocked = "ignore";
    HandleLidSwitchExternalPower = "ignore";
    HandleHibernateKey = "ignore";
    HandleSuspendKey = "ignore";
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

  networking.useDHCP = lib.mkDefault true;
}
