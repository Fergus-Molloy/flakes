{ config, pkgs, lib, ... }:
let
  cfg = config.packages.nvim-custom;
in
with lib;
{
  options.packages.nvim-custom = {
    enable = mkEnableOption (lib.mdDoc "neovim");
  };

  config = mkIf cfg.enable {
    # standard nvim
    programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };
  };
}

# vim: sw=2 ts=2
