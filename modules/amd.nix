{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.graphics.amd;
in
with lib;
{
  options.graphics.amd = {
    enable = mkEnableOption "enable amd drivers";
  };

  config = mkIf cfg.enable {
    boot.initrd.kernelModules = [ "amdgpu" ];
    services.xserver.videoDrivers = [ "amdgpu" ];
    hardware.graphics.enable32Bit = true;
    systemd.tmpfiles.rules =
      let
        rocmEnv = pkgs.symlinkJoin {
          name = "rocm-combined";
          paths = with pkgs.rocmPackages; [
            rocblas
            hipblas
            clr
          ];
        };
      in
      [
        "L+    /opt/rocm   -    -    -     -    ${rocmEnv}"
      ];
  };
}
