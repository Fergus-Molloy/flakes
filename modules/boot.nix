{
  config,
  lib,
  ...
}:
let
  cfg = config.bootloader;
in
with lib;
{
  options.bootloader = {
    enable = mkEnableOption "Enable automatic bootloader configuration";
    windows = mkOption {
      default = { };
      example = {
        "11-win" = {
          title = "Window 11";
          efiDeviceHandle = "HD0b";
        };
      };
      description = ''
        Options to pass to boot.loader.systemd-boot.windows

        efiDeviceHandle can be found by using the edk2 shell and comparing the PARTUUID of 
        windows' boot partition and PARTUUIDs listed by lsblk.
      '';
    };
  };

  config = mkIf cfg.enable {
    boot.loader.systemd-boot = {
      enable = true;
      configurationLimit = 10;
      edk2-uefi-shell.enable = cfg.windows == { };
      windows = cfg.windows;
    };
    boot.loader.efi.canTouchEfiVariables = true;
  };
}
