{ config, lib, pkgs, ... }:
{
  nixpkgs = {
    config = {
      allowUnfree = true;
      packageOverrides = pkgs: {
        linux_4_14 = pkgs.linux_4_14.override {
        extraConfig =
          ''
            MLX5_CORE_EN y
          '';
        };
      };
    };
  };

  boot.kernelPackages = pkgs.linuxPackages_4_14;
  boot.initrd.availableKernelModules = [
    "xhci_pci" "ehci_pci" "ahci" "usbhid" "sd_mod" "megaraid_sas"
    "nvme"
  ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.kernelParams =  [ "console=ttyS1,115200n8" ];
  boot.extraModulePackages = [ ];

  hardware.enableAllFirmware = true;

  nix.maxJobs = 40;
}
