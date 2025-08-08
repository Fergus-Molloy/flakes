{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.roles.vpn;
in
with lib;
{
  imports = [ ../modules/nvim.nix ];
  options.roles.vpn = {
    enable = mkEnableOption "Install vpn";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      wireguard-tools
      (pkgs.writeShellScriptBin "vpn" ''
        #!/usr/bin/env bash
        echo "todo"
      '')
    ];
  };
}
