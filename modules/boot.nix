{
  config,
  lib,
  pkgs,
  lanzaboote,
  ...
}:
let
  cfg = config.bootloader;
in
with lib;
{
  options.bootloader = {
    enable = mkEnableOption "Enable automatic bootloader configuration";
    secureBoot = mkOption {
      type = types.bool;
      default = false;
      description = "Enable lanzaboote and secure boot tools";
    };
    plymouth = mkOption {
      type = types.bool;
      default = false;
      description = "Enable plymouth splash screen";
    };
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
    boot.plymouth.enable = cfg.plymouth;

    environment.systemPackages = optionals cfg.secureBoot [
      pkgs.sbctl
    ];
    boot.lanzaboote = {
      enable = cfg.secureBoot;
      pkiBundle = "/var/lib/sbctl";
    };

    boot.loader.systemd-boot = {
      enable = !cfg.secureBoot;
      configurationLimit = 10;
      edk2-uefi-shell.enable = cfg.windows == { } && !cfg.secureBoot;
      windows = mkIf (cfg.windows != { } && !cfg.secureBoot) cfg.windows;
    };
    boot.loader.efi.canTouchEfiVariables = true;
  };
}
