{ config, pkgs, lib, ... }:
let
  cfg = config.packages.nvim-custom;
in
with lib;
{
  options.packages.nvim-custom = {
    enable = mkEnableOption (lib.mdDoc "neovim");
    lsps = mkOption {
    type = types.listOf types.package;
    default = [];
    example = [pkgs.stylua];
    description = ''
    List of packages to install globally for use with nvim. For example lsps and formatters.
    '';
    };
  };

  config = mkIf cfg.enable {
    # standard nvim
    programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };

    environment.systemPackages = cfg.lsps;
  };
}

# vim: sw=2 ts=2
