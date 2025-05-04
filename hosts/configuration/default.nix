{
  config,
  lib,
  ...
}:
{
  imports = [
    ../../roles
    ./audio.nix
    ./locales.nix
    ./networking.nix
    ./nix.nix
    ./packages.nix
    ./peripherals.nix
    ./user.nix
  ];

  powerManagement.cpuFreqGovernor = lib.mkDefault "schedutil";

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # for mounting usb devices
  services.udisks2.enable = true;
}
