{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.roles.gaming;
in
with lib;
{
  imports = [
    ../modules/nvidia.nix
    ../modules/amd.nix
  ];
  options.roles.gaming = {
    enable = mkEnableOption "Gaming modules";
    graphics = mkOption {
      type = types.enum [
        "nvidia"
        "amd"
      ];
      default = "";
    };
    steam = mkOption {
      type = types.bool;
      default = true;
    };
    minecraft = mkOption {
      type = types.bool;
      default = true;
    };
    amd = mkOption {
      type = types.bool;
      default = false;
    };
    nvidia = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    graphics."${cfg.graphics}".enable = true;

    # enable steam
    programs.steam = {
      enable = cfg.steam;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };

    environment.systemPackages = [
      pkgs.discord
    ] ++ optionals cfg.minecraft [ pkgs.prismlauncher ];

    nixpkgs.overlays = [
      # This overlay will pull the latest version of Discord
      (self: super: {
        discord = super.discord.overrideAttrs (_: {
          src = builtins.fetchTarball {
            url = "https://discord.com/api/download?platform=linux&format=tar.gz";
            sha256 = "1ivcw1cdxgms7dnqy46zhvg6ajykrjg2nkg91pibv60s5zqjqnj2";
          };
        });
      })
    ];
  };

  #TODO: setup nvidia/amd drivers and such
}
