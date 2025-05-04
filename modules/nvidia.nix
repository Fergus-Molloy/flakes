{ config, lib, ... }:
let
  cfg = config.graphics.nvidia;
in
with lib;
{
  options.graphics.nvidia = {
    enable = mkEnableOption "enable nvidia drivers";
  };
  config = mkIf cfg.enable {
    services.xserver.videoDrivers = [ "nvidia" ];

    hardware.nvidia = {
      modesetting.enable = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.beta;
    };
  };
}
