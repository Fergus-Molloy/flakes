{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.roles.streamer;
  davinci-amd = pkgs.runCommand "davinci-amd" { buildInputs = [ pkgs.makeWrapper ]; } ''
    makeWrapper ${pkgs.davinci-resolve}/bin/davinci-resolve $out/bin/davinci-amd --set  RUSTICL_ENABLE "amdgpu,amdgpu-pro,radv,radeon,radeonsi"
  '';
in
with lib;
{
  options.roles.streamer = {
    enable = mkEnableOption "Enable streaming software";
    obsPlugins = mkOption {
      type = types.listOf types.package;
      default = [ ];
      description = "Extra obs plugins";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      davinci-amd
      (wrapOBS {
        plugins =
          with pkgs.obs-studio-plugins;
          [
            wlrobs
            obs-backgroundremoval
            obs-pipewire-audio-capture
          ]
          ++ cfg.obsPlugins;
      })
    ];

    # enable virtual camera
    boot.extraModulePackages = with config.boot.kernelPackages; [
      v4l2loopback
    ];
    boot.kernelModules = [ "v4l2loopback" ];
    boot.extraModprobeConfig = ''
      options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
    '';
    security.polkit.enable = true;

    hardware.graphics = {
      enable = true;
      extraPackages = with pkgs; [
        mesa.opencl # Enables Rusticl (OpenCL) support
      ];
    };
  };
}
