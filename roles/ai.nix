{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.roles.ai;
in
with lib;
{
  imports = [
    ../modules/nvidia.nix
    ../modules/amd.nix
  ];
  options.roles.ai = {
    enable = mkEnableOption "ai modules";
    pkgOverride = mkPackageOption pkgs "ollama" { };
    models = mkOption {
      type = types.listOf types.str;
      default = [ ];
      description = "list of models to pull automatically";
    };
  };

  config = mkIf cfg.enable {
    services.ollama = {
      enable = true;
      package = cfg.pkgOverride;
      acceleration = if config.roles.gaming.graphics == "amd" then "rocm" else "cuda";
      loadModels = cfg.models;
    };
  };
}
