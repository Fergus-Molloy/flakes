{
  config,
  lib,
  pkgs,
  lanzaboote,
  ...
}:
let
  cfg = config.bluetooth;
in
with lib;
{
  options.bluetooth = {
    enable = mkEnableOption "Enable blue tooth";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      bluez
    ];
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          Experimental = true;
        };
      };
    };
  };
}
